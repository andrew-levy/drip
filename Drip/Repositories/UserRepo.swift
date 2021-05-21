//
//  UserRepo.swift
//  Drip
//
//  Created by Andrew Levy on 4/23/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserRepo: ObservableObject {
    private let path = "user"
    private let store = Firestore.firestore()
    private let userID = UserDefaults.standard.string(forKey: "userID")
    private let lastTimestamp = UserDefaults.standard.object(forKey: "lastTimestamp") as? Date ?? Date()
    @Published var user = User()
    @Published var bottles = [Bottle]()
    
    init() {
        getUser()
//        resetProgress()
    }
    
    func resetProgress() {
        if lastTimestamp != nil {
            let now = Date()
            if !isSameDay(date1: now, date2: lastTimestamp) {
                store
                   .collection(path)
                   .document(userID ?? "")
                   .setData(["progress": 0], merge: true) { err in
                       if let err = err {
                           print("Error resetting progress: \(err)")
                       } else {
                           print("Progress successfully reset!")
                       }
                   }
                UserDefaults.standard.setValue(now, forKey: "lastTimestamp")
            }
        } else {
            UserDefaults.standard.setValue(Date(), forKey: "lastTimestamp")
        }
    }
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if diff.day == 0 {
            return true
        } else {
            return false
        }
    }
    
    func getUser() {
        store
            .collection(path)
            .addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    print(error)
                    return
                }
                let match = querySnapshot?.documents.first { document in
                    self.userID == document.documentID
                }
                let result = Result {
                    try match?.data(as: User.self)
                }
                switch result {
                case .success(let user):
                    if let user = user {
                        self.user = user
                        self.bottles = user.bottles
                    } else {
                        print("Document does not exist")
                    }
                case .failure(let error):
                    print("Error decoding user: \(error)")
                }
            }
    }
    
    func addUser(_ user: User) {
        do {
            let docRef = try store.collection(path).addDocument(from: user)
            print("Added user: \(docRef)")
        } catch {
            print("Could not add user")
        }
    }
    
    func deleteUser(_user: User) {
        store
            .collection(path)
            .document(userID ?? "")
            .delete() { err in
                if let err = err {
                    print("Error deleting user: \(err)")
                } else {
                    print("User successfully removed!")
                }
            }
    }
    
    func updateUser(key: String, value: Any) {
        store
            .collection(path)
            .document(userID ?? "")
            .setData([ key: value ], merge: true) { err in
                if let err = err {
                    print("Error updating user: \(err)")
                } else {
                    print("User successfully updated!")
                }
            }
    }
    func addBottle(_ newBottle: Bottle) {
        var updatedUser = user
        updatedUser.bottles.append(newBottle)
        do {
            try store
                .collection(path)
                .document(userID ?? "")
                .setData(from: updatedUser)
        } catch {
            print("Couldn't add bottle")
        }
    }
    func deleteBottle(_ bottleToRemove: Bottle) {
        var updatedUser = user
        let indexToRemove = bottles.firstIndex(of: bottleToRemove)
        updatedUser.bottles.remove(at: indexToRemove!)
        do {
            try store
                .collection(path)
                .document(userID ?? "")
                .setData(from: updatedUser)
        } catch {
            print("Couldn't remove bottle")
        }
    }
}

