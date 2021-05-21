//
//  DripApp.swift
//  Drip
//
//  Created by Andrew Levy on 4/15/21.
//

import SwiftUI
import CoreData
import Firebase

@main
struct DripApp: App {
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
