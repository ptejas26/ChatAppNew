//
//  Extensions.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/10/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import Foundation

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
