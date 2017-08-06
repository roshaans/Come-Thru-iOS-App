//
//  Event.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/19/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import Foundation

class Event2: NSObject {
    
    var whatis2: String
    var whereis2: String
    var whenis2: String
    var AdditionalInfo2: String?
    var usernameCreator2: String?
    
    
    
    init(whatis2: String, whereis2: String, whenis2: String, AdditionalInfo2: String?,usernameCreator2: String? ){
        self.whatis2 = whatis2
        self.whereis2 = whereis2
        self.whenis2 = whenis2
        self.AdditionalInfo2 = AdditionalInfo2
        self.usernameCreator2 = usernameCreator2
    }
    
//    init?(whatis2: String, whereis2: String, whenis2: String, AdditionalInfo2: String?, usernameCreator2: String?){
//        self.whatis2 = whatis2
//        self.whereis2 = whereis2
//        self.whenis2 = whenis2
//        self.AdditionalInfo2 = AdditionalInfo2
//        self.usernameCreator2 = usernameCreator2
//    }
    
    
    
}
