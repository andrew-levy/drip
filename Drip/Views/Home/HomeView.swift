//
//  HomeView.swift
//  Drip
//
//  Created by Andrew Levy on 4/15/21.
//

import SwiftUI
import BottomSheet

struct HomeView: View {
    @StateObject var userRepo = UserRepo()
    private var date: String {
        Date().formatDate()
    }
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    ProgressRingView(
                        progress: userRepo.user.progress,
                        goal: userRepo.user.goal
                    )
                    .frame(width: 250, height: 250)
                    .padding()
                    .previewLayout(.sizeThatFits)
                    Spacer()
                    BottlesGridView(
                        viewModel: BottleGridViewModel(),
                        progress: $userRepo.user.progress
                    )
                }.navigationBarTitle("Today")
            }.padding(.top, 0.3)
        }.onAppear {
            userRepo.resetProgress()
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
