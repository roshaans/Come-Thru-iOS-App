//
//  Event.swift
//  Come Thru
//
//  Created by Roshaan Siddiqui on 7/19/17.
//  Copyright © 2017 Roshaan Siddiqui. All rights reserved.
//

import Foundation

class Event: NSObject {

    var whatis: String
    var whereis: String
    var whenis: String
    var AdditionalInfo: String?
    var usernameCreator: String?
    
    
    
    init(whatis: String, whereis: String, whenis: String, AdditionalInfo: String?){
        self.whatis = whatis
        self.whereis = whereis
        self.whenis = whenis
        self.AdditionalInfo = AdditionalInfo
    }
   
    init?(whatis: String, whereis: String, whenis: String, AdditionalInfo: String?, usernameCreator: String?){
        self.whatis = whatis
        self.whereis = whereis
        self.whenis = whenis
        self.AdditionalInfo = AdditionalInfo
        self.usernameCreator = usernameCreator
    }
    

    
}
