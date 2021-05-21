//
//  BottleCardViewModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import Foundation
import SwiftUI

class BottleCardViewModel: ObservableObject, Identifiable {
    @Published var userRepo = UserRepo()
    @Published var bottle: Bottle
    var nameText: String { bottle.name }
    var sizeText: String {
        String(format: "%.1f", bottle.size) + " " + bottle.unit
    }
    var colors: Dictionary<String, Color> {
        var background: Color
        var foreground: Color
        switch bottle.color {
        case "blue":
            background = Color(UIColor.systemBlue)
            foreground = .white
        case "purple":
            background = Color(UIColor.systemIndigo)
            foreground = .white
        case "red":
            background = Color(UIColor.systemRed)
            foreground = .white
        case "grey":
            background = Color(UIColor.systemGray6)
            foreground = .primary
        default:
            background = Color(UIColor.systemGray6)
            foreground = .primary
        }
        return ["background": background.opacity(0.8), "foreground": foreground]
    }
    
    init(bottle: Bottle) {
        self.bottle = bottle
    }
}
