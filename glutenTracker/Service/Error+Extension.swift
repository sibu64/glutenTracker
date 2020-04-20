//
//  Error+Extension.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 24/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

// Extension to personalize an error 
extension NSError {
    static var noData: NSError {
        return NSError(domain: "darrieumerlou.fr", code: 400, userInfo: [NSLocalizedDescriptionKey: "Data not found"])
    }
}
