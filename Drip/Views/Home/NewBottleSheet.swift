//
//  NewBottleSheet.swift
//  Drip
//
//  Created by Andrew Levy on 4/16/21.
//

import SwiftUI

struct NewBottleSheet: View {
    @ObservedObject var viewModel: NewBottleSheetViewModel
    @Binding var showNewBottleSheet: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Nickname", text: $viewModel.nickname)
                    HStack {
                        TextField("Size", text: $viewModel.size)
                        Picker("", selection: $viewModel.measurementSelection) {
                            ForEach(viewModel.measurements, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Picker("Color", selection: $viewModel.colorSelection) {
                        ForEach(Array(viewModel.colors.keys), id: \.self) { key in
                            HStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(viewModel.colors[key])
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color("StrokeColor"), lineWidth: 1)
                                    )
                                Text(key)
                            }
                        }
                    }
                    .pickerStyle(DefaultPickerStyle())
                }.foregroundColor(.primary)
            }
            .navigationBarTitle("Add a bottle", displayMode: .large)
            .navigationBarItems(
                leading: Button("Cancel", action: {
                    showNewBottleSheet.toggle()
                }),
                trailing: Button("Done", action: {
                    viewModel.createNewBottle()
                    showNewBottleSheet.toggle()
                }).disabled(viewModel.doneDisabled)
            )
            
        }
        
    }
}

struct NewBottleSheet_Previews: PreviewProvider {
    @State static var showNewBottleSheet: Bool = true
    @State static var bottles: [Bottle] = []
    static func addBottle(bottle: Bottle) {
        
    }
    static var previews: some View {
        NewBottleSheet(viewModel: NewBottleSheetViewModel(),
                       showNewBottleSheet: $showNewBottleSheet)
    }
}
