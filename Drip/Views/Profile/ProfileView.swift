//
//  ProfileView.swift
//  Drip
//
//  Created by Andrew Levy on 4/15/21.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack{
                        Section {
                            if (viewModel.isEditing) {
                                Button (action: {
                                    viewModel.showImagePickerSheet.toggle()
                                }){
                                    Image(uiImage: viewModel.profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .sheet(isPresented: $viewModel.showImagePickerSheet) {
                                            ImagePickerSheetView(isPresented: $viewModel.showImagePickerSheet, selectedImage: $viewModel.profileImage)
                                        }.background(Color(UIColor.systemGray6))
                                        .cornerRadius(100)
                                }
                            } else {
                                Image(uiImage: viewModel.profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50, alignment: .leading)
                                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                    .sheet(isPresented: $viewModel.showImagePickerSheet) {
                                        ImagePickerSheetView(isPresented: $viewModel.showImagePickerSheet, selectedImage: $viewModel.profileImage)
                                    }.background(Color(UIColor.systemGray6))
                                    .cornerRadius(100)
                            }
                        }
                        Section {
                            if viewModel.isEditing {
                                TextField("Display Name", text: $viewModel.userCopy.fname)
                            } else {
                                Text(viewModel.userRepo.user.fname)
                            }
                        }
                    }
                    Section {
                        HStack {
                            Text("Daily Water Goal")
                            Spacer()
                            Text(String(format: "%.2f gal", viewModel.userCopy.goal))
                                .foregroundColor(.secondary)
                        }
                        if (viewModel.isEditing) {
                            HStack {
                                Image(systemName: "cloud.drizzle")
                                Slider(value: $viewModel.userCopy.goal, in: 0.1...5.0, step: 0.1)
                                    .padding()
                                Image(systemName: "cloud.rain")
                            }.transition(.opacity)
                            .toggleStyle(SwitchToggleStyle(tint: Color.red))
                        }
                    }
                    Section {
                        HStack {
                            Text("Notifications")
                            Spacer()
                            if (viewModel.isEditing) {
                                Toggle("", isOn: $viewModel.notificationsOn)
                            } else {
                                Text(viewModel.notificationsOn ? "On" : "Off").foregroundColor(.secondary)
                            }
                        }
                        
                    }
                    Section {
                        Button("Sign Out") {
//                            UserDefaults.standard.removeObject(forKey: "userID")
                        }
                        .foregroundColor(Color(UIColor.systemRed))
                    }
                }
            }
            .navigationBarTitle(viewModel.userRepo.user.fname)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            if viewModel.isEditing {
                                viewModel.updateUser()
                            }
                            viewModel.isEditing.toggle()
                        }
                    }) {
                        Image(systemName: viewModel.isEditing ? "checkmark" : "pencil")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if viewModel.isEditing {
                        Button("Cancel") {
                            withAnimation {
                                viewModel.isEditing.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()    }
}
