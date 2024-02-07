//
//  ContentView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
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
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}, label: {
                        Image(symbol: .forward_fill)
                    })
                    .accessibilityLabel("Next speaker")
                }
            }
            .padding(22)
            .foregroundColor(scrum.theme.accentColor)
            .navigationBarTitleDisplayMode(.inline)
            
            // Life cycle
            .onAppear {
                scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
                scrumTimer.startScrum()
            }
            .onDisappear {
                scrumTimer.stopScrum()
            }
        }
    }
}

#Preview {
    MeetingView(scrum: .constant(.emptyScrum))
}
