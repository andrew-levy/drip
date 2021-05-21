//
//  BottleSheetView.swift
//  Drip
//
//  Created by Andrew Levy on 4/16/21.
//

import SwiftUI
import MovingNumbersView


struct BottleSheetView: View {
    @StateObject var viewModel: BottleSheetViewModel
    @Binding var showBottleSheet: Bool
    @Binding var progress: Float
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    Text("+").font(.system(size: 30)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    MovingNumbersView(
                        number: viewModel.formattedMovingNumbers,
                        numberOfDecimalPlaces: 2
                    ) { str in Text(str).font(.system(size: 50)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/) }
                    .mask(viewModel.gradient)
                    .padding(.vertical)
                }
                VStack {
                    viewModel.valueHasChanged
                        ? Button(action: { viewModel.amountToAddOnSubmit = 0 }) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.system(size: 20))
                            
                        }
                        : nil
                }.animation(.spring())
                
                HStack {
                    ForEach(viewModel.addButtons, id: \.self) { button in
                        Button(action: { viewModel.addToTotal(toAdd: button.value) }) {
                            ZStack {
                                Circle()
                                    .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding()
                                    .foregroundColor(Color(UIColor.tertiarySystemBackground))
                                    .shadow(radius: 2)
                                Text("+ \(button.text)")
                                    .foregroundColor(.primary)
                                    .bold()
                            }
                        }
                    }
                }.padding()
            }
            .navigationBarTitle(viewModel.bottle.name, displayMode: .large)
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    viewModel.amountToAddOnSubmit = 0
                    showBottleSheet = false
                }),
                trailing: Button("Done", action: {
//                    progress += Float(viewModel.amountToAddOnSubmit) * viewModel.bottle.size / 128
                    viewModel.userRepo.updateUser(key: "progress", value: progress +  Float(viewModel.amountToAddOnSubmit) * viewModel.bottle.size / 128)
                    showBottleSheet = false
                }).disabled(!viewModel.valueHasChanged)
            )
        }
    }
}

struct BottleSheetView_Previews: PreviewProvider {
    @State static var showBottleSheet: Bool = true;
    @State static var progress: Float = 0
    static var previews: some View {
        BottleSheetView(viewModel: BottleSheetViewModel(bottle: Bottle(id: UUID(), name: "name", size: 3, unit: "oz", color: "blue")), showBottleSheet: $showBottleSheet, progress: $progress)
        
    }
}
