//
//  UserFollowService.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/13/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import UIKit
import Firebase

struct UserFollowService {
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("usersTest").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
                
            })
        }
    }
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("usersTest").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    static func usersExcludingCurrentUser(completion: @escaping ([User]) -> Void) {
        
        let currentUser = User.current.username
        // 1
        let ref = Database.database().reference().child("usersTest")
        
        // 2
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot]
                else { return completion([]) }
            
            // 3
            let users =
                snapshot
                    .flatMap(User.init)
                    .filter { $0.username != currentUser }
            
            // 4
            let dispatchGroup = DispatchGroup()
            users.forEach { (user) in
                dispatchGroup.enter()
                
                // 5
                UserFollowService.isUserFollowed(user) { (isFamily) in
                    user.isFamily = isFamily
                    
                    dispatchGroup.leave()
                }
            }
            
            // 6
            dispatchGroup.notify(queue: .main, execute: {
                completion(users)
            })
        })
        
    }
    
    
    
    
    //                static func followers(for user: User, completion: @escaping ([String]) -> Void) {
    //                    let followersRef = Database.database().reference().child("followers").child(user.uid)
    //
    //                    followersRef.observeSingleEvent(of: .value, with: { (snapshot) in
    //                        guard let followersDict = snapshot.value as? [String : Bool] else {
    //                            return completion([])
    //                        }
    //
    //                        let followersKeys = Array(followersDict.keys)
    //                        completion(followersKeys)
    //                    })
    //                }
    
    
    
    
    
    
    private static func unfollowUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.username
        
        let followData = ["followers/\(user.username)/\(currentUID)" : NSNull(),
                          "following/\(currentUID)/\(user.username)" : NSNull()]
        
        let ref = Database.database().reference()
        ref.updateChildValues(followData) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            }
            
            
            success(true)
            
            
        }
    }
    
    static var followingUsers = [String]()
    
    private static func followUser(_ user: User, forCurrentUserWithSuccess success: @escaping (Bool) -> Void) {
        let currentUID = User.current.username
        let followData = [
            "followers/\(user.username)/\(currentUID)" : true ,
            "following/\(currentUID)/\(user.username)" : true]
        
        
        print("YOU ARE RIGHT HERE")
        let ref = Database.database().reference()
        
        
        ref.updateChildValues(followData) { (error, _) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            }
            
            
            followingUsers.append(user.username)
            success(true)
            
        
        }}
    
    static func setIsFollowing(_ isFamily: Bool, fromCurrentUserTo followee: User, success: @escaping (Bool) -> Void) {
        if isFamily {
            followUser(followee, forCurrentUserWithSuccess: success)
        } else {
            unfollowUser(followee, forCurrentUserWithSuccess: success)
        }
    }
    
    
    static func isUserFollowed(_ user: User, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
        let currentUID = User.current.username
        let ref = Database.database().reference().child("followers").child(user.username)

        ref.queryEqual(toValue: nil, childKey: currentUID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? [String : Bool] {
                completion(true)
            } else {
                completion(false)
            }
        })
    
   
            
            //            let ref2 = Database.database().reference()
            //
            //            let userName = firUser
            
            
            //            ref.setValue(userAttrs) { (error, ref) in
            //                if let error = error {
            //                    assertionFailure(error.localizedDescription)
            //                    return completion(nil)
            //                }
            //                }
            
        
    }
    
    

}
    //    static func addUsername(_ firUser: FIRUser, _ user: User, forfollowedSuccess success: @escaping (Bool) -> Void) {
    //        let ref = Database.database().reference()
    //
    //
    //        let currentUI = User.current.uid
    //
    //    }


