////
////  BottleRepo.swift
////  Drip
////
////  Created by Andrew Levy on 4/23/21.
////
//
//import Foundation
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class BottleRepo: ObservableObject {
//    private let path = "bottle"
//    private let store = Firestore.firestore()
//    @Published var bottles: [Bottle] = []
//
//    init() {
//        getBottles()
//    }
//
//    func getBottles() {
//        store.collection(path).addSnapshotListener { (snapshot, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            self.bottles = snapshot?.documents.compactMap {
//                try? $0.data(as: Bottle.self)
//            } ?? []
//        }
//    }
//
//    func addBottle(_ bottle: Bottle) {
//        do {
//            _ = try store.collection(path).addDocument(from: bottle)
//        } catch {
//            fatalError("Couldn't add bottle")
//        }
//    }
//}
