//
//  Date+Format.swift
//  Drip
//
//  Created by Andrew Levy on 4/20/21.
//

import SwiftUI

extension Date {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        let date = dateFormatter.string(from: self).capitalized
        return date
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

}
