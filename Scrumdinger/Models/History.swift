//
//  History.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
    }
    
    var attendeeListText: String {
//        (self.attendees.map { $0.name }).joined(separator: ", ")
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}
