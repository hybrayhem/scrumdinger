//
//  Picker+AdaptivePickerStyle.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

extension Picker {
    @ViewBuilder
    func pickerStyleNavigationLinkOrWheel() -> some View {
        if #available(iOS 16, *) {
            self.pickerStyle(.navigationLink)
        } else {
            self.pickerStyle(.wheel)
        }
    }
}
