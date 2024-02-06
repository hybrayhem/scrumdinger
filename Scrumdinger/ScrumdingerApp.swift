//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
