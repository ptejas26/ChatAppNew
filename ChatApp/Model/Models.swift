//
//  Models.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/11/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class Models: NSObject {

    struct Login : Decodable {
        var id : String
        var name : String
        var token : String
    }
    
    struct UserList : Decodable {
    
        var id : String
        var name : String
    }
    
    struct SendChat : Decodable {
        
        var message : String
        var toUserId : String
    }
    
    struct AllChar : Decodable
    {
        var message: String
        var fromUserId: String
        var toUserId: String
    }
}
