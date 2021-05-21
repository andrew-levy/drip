//
//  BottleSheetViewModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import Foundation
import SwiftUI

class BottleSheetViewModel: ObservableObject {
    init (bottle: Bottle) {
        self.bottle = bottle
    }
    @Published var userRepo = UserRepo()
    @Published var bottle: Bottle
    @Published var currentValue = 0
    @Published var amountToAddOnSubmit: Float = 0
    @Published var addButtons = [
        AddButton(text: "1/4", value: 0.25),
        AddButton(text: "1/2", value: 0.50),
        AddButton(text: "3/4", value: 0.75),
        AddButton(text: "1", value: 1)
    ]
    var gradient = LinearGradient(
        gradient: Gradient(stops: [
            Gradient.Stop(color: .clear, location: 0),
            Gradient.Stop(color: .black, location: 0.2),
            Gradient.Stop(color: .black, location: 0.8),
            Gradient.Stop(color: .clear, location: 1.0)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    var formattedMovingNumbers: Double {
        Double(Float(currentValue) + amountToAddOnSubmit)
    }
    var valueHasChanged: Bool  {
        amountToAddOnSubmit != 0
    }
    func addToTotal(toAdd: Float) {
        withAnimation {
            amountToAddOnSubmit += Float(toAdd)
        }
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    }
}
