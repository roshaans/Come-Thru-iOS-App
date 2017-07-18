////
////  FollowService.swift
////  Makestagram
////
////  Created by Nida Pervez on 6/29/17.
////  Copyright © 2017 Nida Pervez. All rights reserved.
////
//
//import Foundation
//import FirebaseDatabase
//
//struct FollowService {
//    
//  
//    
//    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
//        let currentUID = User.current.uid
//        let followData = [
//                          "Following/\(currentUID)/\(user.uid)" : true]
//        print("YOU ARE RIGHT HERE")
//        let ref = Database.database().reference()
//        ref.updateChildValues(followData) { (error, _) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                success(false)
//            }
//            
//        }
//    }
//    
//    
//    private static func unfollowUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
//        let currentUID = User.current.uid
//        let followData = [
//                          "following/\(currentUID)/\(user.uid)" : NSNull()]
//        
//        
//        let ref = Database.database().reference()
//        ref.updateChildValues(followData) { (error, ref) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return success(false)
//            }
//            
//            
//        }
//    }
//    
//    static var followingUsers = [User]()
//    static func setIsFollowing(_ isFamily: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
//        
//        if isFamily {
//            print("I am in the isFamily condition")
//            followUser(followee, forCurrentUserWithSuccess: success)
//        } else {
//            unfollowUser(followee, forCurrentUserWithSuccess: success)
//        }
//    }
//    
//    static func myFamily(followingUsers: [User]){
//        
//    }
//    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
//        let currentUID = User.current.uid
//        let ref = Database.database().reference().child("followers").child(user.uid)
//        
//        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let _ = snapshot.value as? [String : Bool] {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        })
//    }
//}
