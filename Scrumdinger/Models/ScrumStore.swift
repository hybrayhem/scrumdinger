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
    
    func load() async throws {
        let task = Task<[DailyScrum], Error> { // returns DailyScrum array, and throws Error
            let file = try Self.fileURL()
            
            guard let data = try? Data(contentsOf: file) else {
                return []
            }
            
            let scrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return scrums
        }
        
        let scrums = try await task.value
        self.scrums = scrums
    }
    
    func save(changedScrums: [DailyScrum]) async throws {
        try await Task {
            let data = try JSONEncoder().encode(changedScrums)
            let file = try Self.fileURL()
            try data.write(to: file)
        }.value
    }
}
