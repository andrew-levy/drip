//
//  HomeViewModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import Foundation
import SwiftUI
import Combine


class BottleGridViewModel: ObservableObject {
    @Published var userRepo = UserRepo()
    @Published var bottles: [Bottle] = []
    @Published var activeBottle: Bottle = Bottle()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userRepo.$bottles
            .assign(to: \.bottles, on: self)
            .store(in: &cancellables)
    }
}
