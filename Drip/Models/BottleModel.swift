//
//  BottleModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import Foundation
import FirebaseFirestoreSwift

struct Bottle: Identifiable, Hashable, Codable {
    var id: UUID
    var name: String
    var size: Float
    var unit: String
    var color: String
    
    init() {
        self.id = UUID()
        self.name = ""
        self.size = 0
        self.unit = "oz"
        self.color = "grey"
    }
    
    init(id: UUID, name: String, size: Float, unit: String, color: String) {
        self.id = id
        self.name = name
        self.size = size
        self.unit = unit
        self.color = color
    }
}
