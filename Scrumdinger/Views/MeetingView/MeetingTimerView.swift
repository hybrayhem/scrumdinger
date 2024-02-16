//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let speakerProgress: Double
    let isRecording: Bool
    let theme: Theme
    
    // View
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 22)
            .overlay {speakerInfoOverlay}
            .overlay {speakerArcsOverlay}
            .padding(.horizontal)
    }
    
    // View Components
    private var speakerInfoOverlay: some View {
        VStack {
            Text(currentSpeaker)
                .font(.title)
            Text("is speaking")
            Image(symbol: isRecording ? .mic : .mic_slash)
                .font(.title)
                .padding(.top)
                .accessibilityLabel(isRecording ? "with transcription" : "without transcription")
        }
        .accessibilityElement(children: .combine)
        .adaptiveForegroundColor(theme.accentColor)
    }
    
    private var speakerArcsOverlay: some View {
        ForEach(Array(speakers.enumerated()), id: \.element.name) { index, speaker in
            SpeakerArcView(
                speakerIndex: index,
                totalSpeakers: speakers.count,
                speakerProgress: speakerProgress(at: index),
                theme: theme
            )
//            .animation(.linear, value: speakerProgress(at: index))
        }
    }
    
    // Computed Properties
    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }
    
    private var currentSpeakerIndex: Int {
        speakers.firstIndex(where: { !$0.isCompleted }) ?? speakers.count - 1
    }
    
    // Helper Functions
    private func speakerProgress(at index: Int) -> Double {
        if index < currentSpeakerIndex { // Speech Done
            return 1.0
        } else if index == currentSpeakerIndex { // Ongoing Speech
            return speakerProgress
        } else { // Speech not started yet
            return 0.0
        }
    }
}

#Preview {
    let speakers = [ScrumTimer.Speaker(name: "Bill", isCompleted: true),
                    ScrumTimer.Speaker(name: "Charlie", isCompleted: false),
                    ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    
    return MeetingTimerView(speakers: speakers, speakerProgress: 0.4, isRecording: true, theme: .seafoam)
}
