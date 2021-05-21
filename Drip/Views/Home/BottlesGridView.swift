//
//  BottlesGridView.swift
//  Drip
//
//  Created by Andrew Levy on 4/16/21.
//

import SwiftUI

struct BottlesGridView: View {
    @ObservedObject var viewModel: BottleGridViewModel
    @Binding var progress: Float
    @State var showBottleSheet = false
    @State var showNewBottleSheet = false
    @State var selectedBottle = -1
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Bottles")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Button (action: {
                    showNewBottleSheet = true
                }) {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 20))
                        .sheet(isPresented: $showNewBottleSheet) {
                            NewBottleSheet(
                                viewModel: NewBottleSheetViewModel(),
                                showNewBottleSheet: $showNewBottleSheet
                            )
                        }
                    
                }
            }.padding(20)
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.bottles, id: \.self.id) { bottle in
                    BottleCardView(
                        viewModel: BottleCardViewModel(bottle: bottle),
                        showBottleSheet: $showBottleSheet,
                        progress: $progress
                    ).onTapGesture {
                        viewModel.activeBottle = bottle
                        showBottleSheet.toggle()
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                    .sheet(isPresented: $showBottleSheet) {
                        BottleSheetView(
                            viewModel: BottleSheetViewModel(bottle: viewModel.activeBottle),
                            showBottleSheet: $showBottleSheet,
                            progress: $progress
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct BottlesGridView_Previews: PreviewProvider {
    @State static var progress = Float.zero
    static var previews: some View {
        BottlesGridView(viewModel: BottleGridViewModel(), progress: $progress)
    }
}
