//
//  HistoryDetailView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct HistoryDetailView: View {
    let history: History
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeListText)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date.dateAndTimeString))
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

#Preview {
    let history: History = History (
        attendees: [
            DailyScrum.Attendee(name: "Jon"),
            DailyScrum.Attendee(name: "Darla"),
            DailyScrum.Attendee(name: "Luis")
        ],
        transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI..."
    )
    
    return NavigationView{
        HistoryDetailView(history: history)
    }
}
