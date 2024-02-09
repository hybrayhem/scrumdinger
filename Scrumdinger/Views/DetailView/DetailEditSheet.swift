//
//  DetailEditSheet.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct DetailEditSheet: View {
    @Binding var scrum: DailyScrum
    @Binding var isPresentingEditSheet: Bool
    @State private var editingScrum = DailyScrum.emptyScrum
    
    var body: some View {
        AdaptiveNavigationStack {
            DetailEditView(scrum: $editingScrum)
                .navigationTitle(editingScrum.title)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingEditSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            scrum = editingScrum
                            isPresentingEditSheet = false
                        }
                    }
                }
        }
        .onAppear {
            editingScrum = scrum // update side effects
        }
    }
}

#Preview {
    DetailEditSheet(
        scrum: .constant(DailyScrum.sampleData[0]),
        isPresentingEditSheet: .constant(true)
    )
}
