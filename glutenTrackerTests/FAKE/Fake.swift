//
//  Fake.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 11/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
@testable import glutenTracker

extension Product {
    static var fake: Product {
        return Product(
            objectId: "10",
            name: "name",
            ingredients: ["lemon"],
            allergens: nil,
            barCode: "123",
            imageUrlString: nil,
            allergensTags: ["tags"]
        )
    }
}

extension NSError {
    static var fake: NSError {
        return NSError(domain: "com.simon", code: 10, userInfo: [NSLocalizedDescriptionKey: "error"])
    }
}
