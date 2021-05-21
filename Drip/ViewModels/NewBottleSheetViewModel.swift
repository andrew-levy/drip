//
//  NewBottleSheetViewModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import Foundation
import SwiftUI

class NewBottleSheetViewModel: ObservableObject {
    @Published var userRepo = UserRepo()
    @Published var nickname: String = ""
    @Published var size: String = ""
    var formattedSize: Float {
        Float(size) ?? 0.0
    }
    var doneDisabled: Bool {
        nickname.isEmpty || size.isEmpty
    }
    @Published var colorSelection = "grey"
    var measurementSelection = "Oz"
    var measurements = ["Oz", "Liter"]
    var colors = [
        "grey": Color(UIColor.systemGray6).opacity(0.8),
        "purple": Color(UIColor.systemIndigo).opacity(0.8),
        "blue": Color(UIColor.systemBlue).opacity(0.8),
        "red": Color(UIColor.systemRed).opacity(0.8)
    ]
    func createNewBottle() {
        let newBottle = Bottle(
            id: UUID(),
            name: nickname,
            size: formattedSize,
            unit: measurementSelection,
            color: colorSelection
        )
        userRepo.addBottle(newBottle)
    }
    
}
