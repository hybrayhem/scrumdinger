//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List(scrums) { scrum in
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColor)
        }
    }
}

#Preview {
    let scrums = DailyScrum.sampleData
    
    return ScrumsView(scrums: scrums)
}

