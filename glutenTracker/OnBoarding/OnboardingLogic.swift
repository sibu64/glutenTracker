//
//  OnboardingLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

public class OnboardingLogic {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    private(set) var saver: ProtocolSaverService?
    private let key = Keys.firstLaunch
    
    public var isFirstLaunch: Bool {
        if let value = saver?.load(key: key) as? Bool {
            return !value
        }
        return true
    }
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    init(saver: ProtocolSaverService? = nil) {
        self.saver = saver
    }
    
    open func finish() {
        saver?.save(key: key, value: true)
    }
}

extension OnboardingLogic {
    public static var `default`: OnboardingLogic = {
        return OnboardingLogic(saver: SaverService.default)
    }()
}

public protocol ProtocolSaverService {
    func load(key:String) ->Any?
    func save(key:String, value: Any?)
}

struct Keys {
    static var firstLaunch = "firstLaunch"
}
