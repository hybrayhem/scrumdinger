//
//  ContentView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording = false
    
    private var avplayer: AVPlayer { .sharedDingPlayer }
    
    var body: some View {
        ZStack {
            CornerRoundedRectangle(cornerRadius: 16, corners: [.bottomLeft, .bottomRight])
                .fill(scrum.theme.mainColor)
                .edgesIgnoringSafeArea(.top)
            VStack {
                // Header Progress
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme)
                
                // Mid Circular
                MeetingTimerView(
                    speakers: scrumTimer.speakers,
                    speakerProgress: scrumTimer.speakerProgress,
                    isRecording: isRecording,
                    theme: scrum.theme)
                
                // Footer
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker)
            }
            .padding(22)
            .foregroundColor(scrum.theme.accentColor)
            .navigationBarTitleDisplayMode(.inline)
            
            // Life cycle
            .onAppear {
                startScrum()
            }
            .onDisappear {
                endScrum()
            }
        }
    }
    
    func startScrum() {
        // Set scrum
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            // Play from start
            avplayer.seek(to: .zero)
            avplayer.play()
        }
        
        // Set speech recognizer
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        
        // Start scrum
        scrumTimer.startScrum()
    }
    
    func endScrum() {
        scrumTimer.stopScrum()
        
        speechRecognizer.stopTranscribing()
        isRecording = false
        
        let newHistory = History(
            attendees: scrum.attendees,
            transcript: speechRecognizer.transcript
        )
        scrum.histories.insert(newHistory, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(.emptyScrum))
}
