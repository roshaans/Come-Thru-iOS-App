//
//  User.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/10/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//


import Foundation
import FirebaseDatabase.FIRDataSnapshot


class User: NSObject {
    
        // MARK: - Properties

        var isFamily = false
        let uid: String
        let username: String
    static var isInMyFamilyList = [String: Bool]()
    
        // MARK: - Init/Users/roshaansiddiqui/Desktop/Makeschool2017/Come Thru/Come Thru.xcodeproj
        init(uid: String, username: String) {
            
            self.uid = uid
            self.username = username
            super.init()
        }
        init?(snapshot: DataSnapshot) {
          
            guard let dict = snapshot.value as? [String : Any],
                let username = dict["username"] as? String
                else {
                    
                    return nil
         
            }
            
            self.uid = snapshot.key
            self.username = username
              super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        
        super.init()
    }
    private static var _current: User?
    static var current: User {
        guard let currentUser = _current else {
            fatalError("Error: current user doesn't exist")
        }
        
        return currentUser
    }
    
    // MARK: - Class Methods
    
    // 5
    class func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        // 2
        if writeToUserDefaults {
            // 3
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            
            // 4
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        
        _current = user
    }


}

extension User: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}
