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
            
            Section(header: Text("History")) {
                if scrum.histories.isEmpty {
//                    if #available(iOS 17.0, *) {
//                        ContentUnavailableView(
//                            "No meeting history",
//                            systemImage: SFSymbols.calendar_badge_exclamationmark.name,
//                            description: Text("Let's start a meeting.")
//                        )
//                    } else {
                        VStack(alignment: .center) {
                            Image(symbol: .calendar_badge_exclamationmark)
                            Text("No meeting history.")
                        }
                        .opacity(0.5)
                        .frame(maxWidth: .infinity)
//                    }
                } else {
                    ForEach(scrum.histories) { history in
                        ExpandableLabel(
                            symbol: .calendar,
                            text: history.date.dateAndTimeString,
                            description: history.attendeeListText
                        ) {
                            if history.transcript != nil {
                                HiddenNavigationLink(
                                    destination: HistoryDetailView(history: history)
                                ) {
                                    Text("Transcript")
                                        .font(.footnote)
                                        .adaptiveForegroundColor(.blue)
                                }

                            }
                        }
                    }
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
    AdaptiveNavigationStack{
        DetailView(scrum: .constant(DailyScrum.sampleDataWithHistory[0]))
    }
}
