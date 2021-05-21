//
//  UserModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/23/21.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    var fname: String
    var lname: String
    var goal: Float
    var progress: Float
    var bottles: [Bottle]
    
    init(id: String, fname: String, lname: String, goal: Float, progress: Float, bottles: [Bottle]) {
        self.id = id
        self.fname = fname
        self.lname = lname
        self.goal = goal
        self.progress = progress
        self.bottles = bottles
    }
    
    init() {
        self.id = "0"
        self.fname = ""
        self.lname = ""
        self.goal = 1
        self.progress = 0
        self.bottles = []
    }
}
