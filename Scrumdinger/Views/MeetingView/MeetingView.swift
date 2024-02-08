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
                    theme: scrum.theme
                )
                
                // Mid Circular
                Circle()
                    .strokeBorder(lineWidth: 22)
                
                // Footer
                MeetingFooterView(
                    speakers: scrumTimer.speakers,
                    skipAction: scrumTimer.skipSpeaker
                )
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
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.startScrum()
        
        scrumTimer.speakerChangedAction = {
            // Play from start
            avplayer.seek(to: .zero)
            avplayer.play()
        }
    }
    
    func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.histories.insert(newHistory, at: 0)
    }
}

#Preview {
    MeetingView(scrum: .constant(.emptyScrum))
}
