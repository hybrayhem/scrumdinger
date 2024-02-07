//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

// TODO: Fix timer logic
struct MeetingFooterView: View {
    // Properties
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    
    // View
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction, label: {
                        Image(symbol: .forward_fill)
                    })
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
    
    // Computed Variables
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !($0.isCompleted) }) else { return nil }
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
//        return speakers.dropLast().allSatisfy { $0.isCompleted }
        return speakerNumber == speakers.count
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
}

@available(iOS 17, *)
#Preview(traits: .sizeThatFitsLayout) {
    MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
}
