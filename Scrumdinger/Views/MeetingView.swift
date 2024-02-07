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
                ProgressView(value: 5, total: 15)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Seconds Elapsed")
                            .font(.caption)
                        Label("300", symbol: .hourglass_tophalf_fill)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Seconds Remaining")
                            .font(.caption)
                        Label("600", symbol: .hourglass_bottomhalf_fill)
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Time remaining")
                .accessibilityValue("10 minutes") // Update this programmatically
                
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
