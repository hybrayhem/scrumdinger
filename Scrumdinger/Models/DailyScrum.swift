//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation

struct DailyScrum: Identifiable, Codable {
    let id: UUID
    
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    var lengthInMinutesAsDouble: Double {
        get { Double(lengthInMinutes) }
        set { lengthInMinutes = Int(newValue) }
    }
    var theme: Theme
    var histories: [History] = []
    
    // Assign a default UUID
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map { Attendee(name: $0) } // Create unique Attendee's from name string
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
}

extension DailyScrum: Equatable {
    static func == (lhs: DailyScrum, rhs: DailyScrum) -> Bool {
        return lhs.id == rhs.id
    }
}

extension DailyScrum {
    struct Attendee: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
}

// Static sample data
extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(
            title: "Design",
            attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
            lengthInMinutes: 10,
            theme: .yellow
        ),
        DailyScrum(
            title: "App Dev",
            attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
            lengthInMinutes: 5,
            theme: .orange
        ),
        DailyScrum(
            title: "Web Dev",
            attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
            lengthInMinutes: 5,
            theme: .poppy
        )
    ]
    
    static var sampleDataWithHistory: [DailyScrum] {
        var scrums = sampleData
        scrums[0].histories = [
            History(date: Date(), attendees: [Attendee(name: "Cathy"), Attendee(name: "Simon")]),
            History(date: Date(timeIntervalSinceNow: TimeInterval(integerLiteral: 12345678)), attendees: [Attendee(name: "Daisy")])
        ]
        return scrums
    }
}
