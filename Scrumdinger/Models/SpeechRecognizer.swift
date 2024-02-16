//
//  SpeechRecognizer.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation
import AVFoundation
import Speech
import SwiftUI

// SpeechRecognizer actor that handles speech recognition tasks
actor SpeechRecognizer: ObservableObject {
    // Error types for the speech recognizer
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    // Properties of speech recognition
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    // Published property for transcript
    @MainActor var transcript: String = ""
    
    init() {
        recognizer = SFSpeechRecognizer()
        guard recognizer != nil else {
            transcribe(
                RecognizerError.nilRecognizer
            )
            return
        }
        
        Task {
            do {
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else { // Speech Recognition Permission
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else { // Microphone Usage Permission
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                transcribe(
                    error
                )
            }
        }
    }
    
    @MainActor func startTranscribing() {
        Task {
            await transcribe()
        }
    }
    
    @MainActor func resetTranscript() {
        Task {
            await reset()
        }
    }
    
    @MainActor func stopTranscribing() {
        Task {
            await reset()
        }
    }
    
    // Helpers
    private func transcribe() {
        guard let recognizer, recognizer.isAvailable else {
            self.transcribe(
                RecognizerError.recognizerIsUnavailable
            )
            return
        }
        
        do {
            let (
                audioEngine,
                request
            ) = try Self.prepareEngine()
            self.audioEngine = audioEngine
            self.request = request
            self.task = recognizer.recognitionTask(with: request,
                                                   resultHandler: {
                [weak self] result,
                error in
                self?.recognitionHandler(
                    audioEngine: audioEngine,
                    result: result,
                    error: error
                )
            })
        } catch {
            self.reset()
            self.transcribe(
                error
            )
        }
    }
    
    private func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    private static func prepareEngine() throws -> (
        AVAudioEngine,
        SFSpeechAudioBufferRecognitionRequest
    ) {
        let audioEngine = AVAudioEngine()
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(
            .playAndRecord,
            mode: .measurement,
            options: .duckOthers
        )
        try audioSession.setActive(
            true,
            options: .notifyOthersOnDeactivation
        )
        let inputNode = audioEngine.inputNode
        
        let recordingFormat = inputNode.outputFormat(
            forBus: 0
        )
        inputNode.installTap(
            onBus: 0,
            bufferSize: 1024,
            format: recordingFormat
        ) { (
            buffer: AVAudioPCMBuffer,
            when: AVAudioTime
        ) in
            request.append(
                buffer
            )
        }
        audioEngine.prepare()
        try audioEngine.start()
        
        return (
            audioEngine,
            request
        )
    }
    
    nonisolated private func recognitionHandler(
        audioEngine: AVAudioEngine,
        result: SFSpeechRecognitionResult?,
        error: Error?
    ) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        
        if receivedFinalResult || receivedError {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(
                onBus: 0
            )
        }
        
        if let result {
            transcribe(
                result.bestTranscription.formattedString
            )
        }
    }
    
    
    nonisolated private func transcribe(
        _ message: String
    ) {
        Task { @MainActor in
            transcript = message
        }
    }
    nonisolated private func transcribe(
        _ error: Error
    ) {
        var errorMessage = ""
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        Task { @MainActor [errorMessage] in
            transcript = "<< \(errorMessage) >>"
        }
    }
}

// Permission check extensions
extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(
                    returning: status == .authorized
                )
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(
                    returning: authorized
                )
            }
        }
    }
}
