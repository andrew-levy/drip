//
//  MainView.swift
//  Drip
//
//  Created by Andrew Levy on 4/15/21.
//

import SwiftUI


// fetch user data, store some stuff in the device, update global settings
// if setting is updated, need to send to db
struct MainView: View {
    @State private var selection: Int = 2
    var body: some View {
        TabView(selection: $selection) {
            ProfileView().tabItem {
                Image(systemName: "person").padding()
            }.tag(1)
            HomeView().tabItem {
                Image(systemName: "cloud.drizzle").padding()
            }.tag(2)
            WeekView().tabItem {
                Image(systemName: "chart.bar").padding()
            }.tag(3)
        }.onAppear() {
            UITabBar.appearance().barTintColor = UIColor.white
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
