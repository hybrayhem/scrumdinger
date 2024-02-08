//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct MeetingHeaderView: View {
    // MARK: Properties
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    // MARK: View
    var body: some View {
        VStack {
            ProgressView(value: Double(secondsElapsed), total: Double(totalSeconds))
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", symbol: .hourglass_tophalf_fill)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", symbol: .hourglass_bottomhalf_fill)
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Time remaining")
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
    
    // MARK: Logic
    private var minutesRemaining: Int { secondsRemaining / 60 }
    
    private var totalSeconds: Int { secondsElapsed + secondsRemaining }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    MeetingHeaderView(secondsElapsed: 300, secondsRemaining: 600, theme: .navy)
}
