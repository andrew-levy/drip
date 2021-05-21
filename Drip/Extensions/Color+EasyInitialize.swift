//
//  Color+EasyInitialize.swift
//  Drip
//
//  Created by Andrew Levy on 4/19/21.
//

import SwiftUI

extension Color {
    init(r: Int, g: Int, b: Int) {
        self.init(red: Double(r)/255.0, green: Double(g)/255.0, blue: Double(b)/255.0)
    }
}
