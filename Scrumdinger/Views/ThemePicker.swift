//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme // Will refer to scrum.theme from detail view
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink) // TODO: make wheel
    }
}

#Preview {
    ThemePicker(selection: .constant(.bubblegum))
}
