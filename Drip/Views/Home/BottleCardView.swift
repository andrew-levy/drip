//
//  BottleCardView.swift
//  Drip
//
//  Created by Andrew Levy on 4/18/21.
//

import SwiftUI

struct BottleCardView: View {
    @ObservedObject var viewModel: BottleCardViewModel
    @Binding var showBottleSheet: Bool
    @Binding var progress: Float
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame")
                    .font(.system(size: 20))
                Spacer()
            }
            Spacer()
            Spacer()
            Text(viewModel.nameText)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .font(.system(size: 15))
            Text(viewModel.sizeText)
                .font(.system(size: 10))
        }
        .frame(width: 130, height: 40)
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(viewModel.colors["background"])
        .foregroundColor(viewModel.colors["foreground"])
        .cornerRadius(10)
        .contextMenu {
            Button(action: {
                let size = viewModel.bottle.size / 128
//                progress += size
                viewModel.userRepo.updateUser(key: "progress", value: progress + size)
            }) {
                Label("Quick Add", systemImage: "plus")
            }
            Button(action: {
                // Open a new sheet that edits the array, also need a binding
            }) {
                Label("Edit", systemImage: "pencil")
            }
            Button(action: {
                viewModel.userRepo.deleteBottle(viewModel.bottle)
            }) {
                Label("Delete", systemImage: "trash").foregroundColor(.red)
            }
        }
    }
}

struct BottleCardView_Previews: PreviewProvider {
    @State static var showBottleSheet: Bool = true;
    @State static var bottle: Bottle = Bottle(id: UUID(), name: "test", size: 24, unit: "oz", color: "blue")
    @State static var progress: Float = 0
    static var previews: some View {
        BottleCardView(
            viewModel: BottleCardViewModel(bottle: bottle),
            showBottleSheet: $showBottleSheet,
            progress: $progress
        )
    }
}
