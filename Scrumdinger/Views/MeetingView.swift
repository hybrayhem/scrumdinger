//
//  ContentView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            // Header Progress
            ProgressView(value: 5, total: 15)
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("10 minutes") // Update this programmatically
            
            // Mid Circular
            Circle()
                .strokeBorder(lineWidth: 24)
            
            // Footer
            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "forward.fill")
                })
                .accessibilityLabel("Next speaker")
            }
        }
        .padding()
    }
}

#Preview {
    MeetingView()
}
