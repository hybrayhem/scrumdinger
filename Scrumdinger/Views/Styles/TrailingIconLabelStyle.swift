//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() } // allows TrailingIconLabelStyle to be called with dot syntax
}
