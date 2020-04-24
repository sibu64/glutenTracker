//
//  Credential.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 25/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

public struct Credential {
    static func save(email: String?, and userId: String) {
        KeychainWrapper.standard.set(userId, forKey: "userId")
        if let value = email {
            KeychainWrapper.standard.set(value, forKey: "email")
        }
    }
    
    static func remove(email: String?, and userId: String) {
        KeychainWrapper.standard.removeAllKeys()
    }
    
    static func retrieveUserId() ->String? {
        return KeychainWrapper.standard.string(forKey: "userId")
    }
    
    static func retrieveUserEmail()->String? {
        return KeychainWrapper.standard.string(forKey: "email")
    }
}
