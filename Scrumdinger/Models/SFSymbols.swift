//
//  SFSymbols.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import SwiftUI

enum SFSymbols: String {
    case plus
    case plus_circle_fill
    case hourglass_tophalf_fill
    case hourglass_bottomhalf_fill
    case forward_fill
    case person
    case person_3
    case clock
    case timer
    case paintpalette
    case calendar
    case calendar_badge_exclamationmark

    var name: String {
        return self.rawValue.snakeCaseToDots
    }
    
    var image: Image {
        return Image(systemName: self.name)
    }
}

extension Image {
    init(symbol: SFSymbols) {
        self.init(systemName: symbol.name)
    }
}

extension Label where Title == Text, Icon == Image {
    init(_ title: String, symbol: SFSymbols) {
        self.init(title, systemImage: symbol.name)
    }
}
