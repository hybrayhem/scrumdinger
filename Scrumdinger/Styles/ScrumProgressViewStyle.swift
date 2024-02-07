//
//  ScrumProgressViewStyle.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ScrumProgressViewStyle: ProgressViewStyle {
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)
                    .tint(theme.mainColor)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            }
        }
    }
}

@available(iOS 17.0, *)
#Preview(traits: .sizeThatFitsLayout) {
    ProgressView(value: 0.55)
        .progressViewStyle(ScrumProgressViewStyle(theme: .lavender))
}
