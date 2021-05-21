//
//  ContentView.swift
//  Drip
//
//  Created by Andrew Levy on 4/15/21.
//

import SwiftUI

struct ContentView: View {
    private var userID = UserDefaults.standard.string(forKey: "userID") ?? ""
    var isAuth: Bool {
        !userID.isEmpty
    }
    init() {
        // need to actually set the user id in login/signup
        if !isAuth {
            UserDefaults.standard.setValue("HC5XufRnh8OV0vAvXRt6", forKey: "userID")
        }
    }
    var body: some View {
        if (isAuth) {
            MainView()
        } else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
