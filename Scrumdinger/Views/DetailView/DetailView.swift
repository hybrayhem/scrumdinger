//
//  DetailView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Properties
    @Binding var scrum: DailyScrum
    @State private var isPresentingEditSheet = false
    
    // MARK: - View
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("Start Meeting", symbol: .timer)
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", symbol: .clock)
                    Spacer()
                    Text("\(scrum.lengthInMinutes)")
                }
                .accessibilityElement(children: .combine) // combine label and text
                HStack {
                    Label("Theme", symbol: .paintpalette)
                    Spacer()
                    Text("\(scrum.theme.name)")
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Label("\(attendee.name)", symbol: .person)
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditSheet = true
            }
        }
        .sheet(isPresented: $isPresentingEditSheet) {
            DetailEditSheet(scrum: $scrum, isPresentingEditSheet: $isPresentingEditSheet)
        }
    }
}

#Preview {
    NavigationStack{
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
