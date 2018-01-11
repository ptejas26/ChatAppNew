//
//  UserDefault.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/11/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class UserDefault: NSObject {

    func getToken() -> String
    {
        UserDefaults.standard.synchronize()
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else
        {
            return ""
        }
        return token
    }
    func setToken(_ token: String)
    {
        UserDefaults.standard.synchronize()
        UserDefaults.standard.set(token, forKey: "token")
    }
}
