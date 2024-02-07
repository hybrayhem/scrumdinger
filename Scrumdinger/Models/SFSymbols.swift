//
//  SFSymbols.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation



enum SFSymbols: String {
    case plus
    case hourglass_tophalf_fill
    case hourglass_bottomhalf_fill
    case forward_fill
    case person_3
    case clock
    case timer
    case paintpalette

    var name: String {
        return self.rawValue.snakeCaseToDots
    }
}
