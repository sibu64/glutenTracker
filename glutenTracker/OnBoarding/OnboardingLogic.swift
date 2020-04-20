//
//  OnboardingLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

// Class which contains the logic to make the controller worked
public class OnboardingLogic {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    //Declaration of the ProtocolSaverService saver
    private(set) var saver: ProtocolSaverService?
    
    //Declaration of key
    private let key = Keys.firstLaunch
    
    // Declaration of isFirstLaunch
    public var isFirstLaunch: Bool {
        if let value = saver?.load(key: key) as? Bool {
            return !value
        }
        return true
    }
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    //Initalization of saver
    init(saver: ProtocolSaverService? = nil) {
        self.saver = saver
    }
    
    // Saves the key of an iCloud account when it's declared available(onBoardingViewController)
    open func finish() {
        saver?.save(key: key, value: true)
    }
}

// Extension to declare the default use case of onBoarding
extension OnboardingLogic {
    public static var `default`: OnboardingLogic = {
        return OnboardingLogic(saver: SaverService.default)
    }()
}

// ProtocolSaverService to load and save
public protocol ProtocolSaverService {
    func load(key:String) ->Any?
    func save(key:String, value: Any?)
}

// Declaration of firstLaunch
struct Keys {
    static var firstLaunch = "firstLaunch"
}
