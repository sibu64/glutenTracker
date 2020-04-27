//
//  JSON+Extension.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 30/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

//Extensions to retrieve the JSON from the Bundle
extension Bundle {
    static var bundle:Bundle? = {
        let testBundle = Bundle.allBundles
        
        let testTarget = testBundle.filter({ value -> Bool in
            value.bundleURL.lastPathComponent == "glutenTrackerTests.xctest"
        }).first!
        
        let bundle = Bundle(identifier: testTarget.bundleIdentifier!)
        return bundle
    }()
}

extension Data {
    static func from(_ ressource: String) -> Data {
        let path = Bundle.bundle?.path(forResource: ressource, ofType: "json")
        return try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    }
}
