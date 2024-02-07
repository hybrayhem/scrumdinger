//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct DetailEditView: View {
    // MARK: - States
    @State private var scrum = DailyScrum.emptyScrum
    @State private var newAttendeeName = ""
    
    // MARK: - View
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title) // create binding to scrum.title
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1, label: {
                        Text("Length")
                    })
                    .accessibilityValue(lengthInMinutesString)
                    Spacer()
                    Text(lengthInMinutesString).monospacedDigit()
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete(perform: { indexSet in
                    scrum.attendees.remove(atOffsets: indexSet)
                })
                
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    
                    Button(action: {
                        withAnimation {
                            addNewAttendee()
                        }
                    }) {
                        Image(symbol: .plus_circle_fill)
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(isNewAttendeeNameEmpty)
                }
            }
        }
    }
    
    // MARK: - Methods
    private var lengthInMinutesString: String {
        String(format: "%2d minutes", scrum.lengthInMinutes)
    }
    
    private func addNewAttendee() {
        let newAttendee = DailyScrum.Attendee(name: newAttendeeName)
        scrum.attendees.append(newAttendee)
        newAttendeeName = "" // Reset
    }

    private var isNewAttendeeNameEmpty: Bool {
        return newAttendeeName.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

#Preview {
    DetailEditView()
}
