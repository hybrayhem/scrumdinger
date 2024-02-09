//
//  View+AdaptiveForegroundColor.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

extension View {
    @ViewBuilder
    func adaptiveForegroundColor(_ color: Color) -> some View {
        if #available(iOS 15, *) {
            self.foregroundStyle(color)
        } else {
            self.foregroundColor(color)
        }
    }
}
