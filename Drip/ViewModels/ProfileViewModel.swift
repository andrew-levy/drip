//
//  ProfileViewModel.swift
//  Drip
//
//  Created by Andrew Levy on 4/22/21.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userRepo = UserRepo()
    @Published var userCopy = User()
    @Published var showImagePickerSheet = false
    @Published var isEditing = false
    @Published var notificationsOn = false
    @Published var profileImage = UIImage()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        userRepo.$user
            .assign(to: \.userCopy, on: self)
            .store(in: &cancellables)
    }
    
    func updateUser() {
        if userCopy.fname != userRepo.user.fname && userCopy.fname != "" {
            userRepo.updateUser(key: "fname", value: userCopy.fname)
        }
        if userCopy.goal != userRepo.user.goal {
            userRepo.updateUser(key: "goal", value: userCopy.goal)
        }
    }
}
