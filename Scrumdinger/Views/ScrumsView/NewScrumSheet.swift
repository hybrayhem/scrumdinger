//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct NewScrumSheet: View {
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumView: Bool
    @State private var newScrum = DailyScrum.emptyScrum
    
    var body: some View {
        AdaptiveNavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingNewScrumView = false
                        }
                    }
                    
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheet(
        scrums: .constant(DailyScrum.sampleData),
        isPresentingNewScrumView: .constant(true)
    )
}
