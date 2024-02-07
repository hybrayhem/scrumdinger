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
    
    // MARK: - States
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
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
                editingScrum = scrum
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                scrum = editingScrum
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack{
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
