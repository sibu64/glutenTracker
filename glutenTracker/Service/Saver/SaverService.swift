//
//  SaverService.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

// class to set up a protocol to save and load data to userDefaults
class SaverService: ProtocolSaverService {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    let userDefaults: UserDefaults
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    func save(key: String, value: Any?) {
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    func load(key: String) -> Any? {
        return userDefaults.value(forKey: key)
    }
}
// Extension to declare the default use case of SaverService
extension SaverService {
    static var `default`: SaverService = {
        return SaverService()
    }()
}
