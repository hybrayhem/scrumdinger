//
//  Date+format.swift
//  Scrumdinger
//
//  Created by hybrayhem.
//

import Foundation

extension Date {
    var dateAndTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short  
        //
        return dateFormatter.string(from: self)
    }
}
