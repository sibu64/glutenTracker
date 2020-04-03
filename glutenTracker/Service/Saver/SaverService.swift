//
//  SaverService.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

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

extension SaverService {
    static var `default`: SaverService = {
        return SaverService()
    }()
}
