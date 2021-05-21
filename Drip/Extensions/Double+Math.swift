//
//  Double+Math.swift
//  Drip
//
//  Created by Andrew Levy on 4/20/21.
//

import SwiftUI

extension Double {
    func toRadians() -> Double {
        return self * Double.pi / 180
    }
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}
