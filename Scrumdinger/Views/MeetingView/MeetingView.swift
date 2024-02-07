//
//  ContentView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                // Header Progress
                MeetingHeaderView(secondsElapsed: 15, secondsRemaining: 20, theme: scrum.theme)
                
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
        }
    }
}

#Preview {
    MeetingView(scrum: .constant(.emptyScrum))
}
