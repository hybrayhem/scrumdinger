//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation

// Observable Data Source for Views
@MainActor
class ScrumStore: ObservableObject {
    @Published var scrums: [DailyScrum] = [] // runs on main thread since subscribers are views
    
    private static let dataFileName = "scrums.data"
    private static func fileURL() throws -> URL {
        // Get app document directory
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent(dataFileName)
    }
}
