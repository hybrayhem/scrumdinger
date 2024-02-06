//
//  String+camelCaseToDots.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation

extension String {
    var camelCaseToDots: String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) || CharacterSet.decimalDigits.contains($1) {
                return ($0 + "." + String($1)).lowercased()
            } else {
                return $0 + String($1)
            }
        }
    }
    
    var snakeCaseToDots: String {
        return self.replacingOccurrences(of: "_", with: ".")
    }
    
}
