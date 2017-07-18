////
////  UserService.swift
////  Come Thru
////
////  Created by Roshaan Siddiqui on 7/10/17.
////  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
////
//
//import Foundation
//import FirebaseAuth.FIRUser
//import FirebaseDatabase
////
//    struct UserService {
//        
//        static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
//            let userAttrs = ["username": username]
//            
//            let ref = Database.database().reference().child("users").child(firUser.uid)
//            ref.setValue(userAttrs) { (error, ref) in
//                if let error = error {
//                    assertionFailure(error.localizedDescription)
//                    return completion(nil)
//                }
//                
//                ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                    let user = User(snapshot: snapshot)
//                    completion(user)
//                })
//            }
//            
//        }
//
//        static func usersExcludingCurrentUser(completion: @escaping ([User]) -> Void) {
//            
//            let currentUser = User.current
//            // 1
//            let ref = Database.database().reference().child("users")
//            
//            // 2
//            ref.observeSingleEvent(of: .value, with: { (snapshot) in
//                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
//                    else { return completion([]) }
//                
//                // 3
//                let users =
//                    snapshot
//                        .flatMap(User.init)
//                        .filter { $0.uid != currentUser.uid }
//                
//                // 4
//                let dispatchGroup = DispatchGroup()
//                users.forEach { (user) in
//                    dispatchGroup.enter()
//                    
//                    // 5
//                    //FollowService.isUserFollowed(user) { (isFamily) in
//                    //user.isFamily = isFamily
//                        
//                       
//                        dispatchGroup.leave()
//                    }
//              //  }
//                
//                // 6
//                dispatchGroup.notify(queue: .main, execute: {
//                    completion(users)
//                })
//            })
//        }
//
//        static func followers(for user: User, completion: @escaping ([String]) -> Void) {
//            let followersRef = Database.database().reference().child("followers").child(user.uid)
//            
//            followersRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                guard let followersDict = snapshot.value as? [String : Bool] else {
//                    return completion([])
//                }
//                
//                let followersKeys = Array(followersDict.keys)
//                completion(followersKeys)
//            })
//        }}
