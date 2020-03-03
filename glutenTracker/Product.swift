//
//  Product.swift
//  FoodTracker
//
//  Created by Darrieumerlou on 11/05/2018.
//  Copyright © 2018 Darrieumerlou. All rights reserved.
//

import Foundation

struct Product {
    let objectId: String?
    let name: String?
    let ingredients: [String]?
    let allergens: String?
    let barCode: String?
    let imageUrlString: String?
    var imageUrl: URL? {
        if let string = imageUrlString {
           return URL(string: string)
        }
        return nil
    }
    
    init(objectId: String?, name: String?, ingredients: [String]?, allergens: String?, barCode: String?, imageUrlString: String?) {
        self.objectId = objectId
        self.name = name
        self.ingredients = ingredients
        self.allergens = allergens
        self.barCode = barCode
        self.imageUrlString = imageUrlString
    }
}

extension Product {
    init(json: [String: Any]) {
        let objectId = json["_id"] as? String
        let name = json["product_name_fr"] as? String
        let imageUrlString = json["image_front_url"] as? String
        let ingredients = json["ingredients_ids_debug"] as? [String]
        let allergens = json["allergens"] as? String
        let barcode = json["code"] as? String
        
        self.objectId = objectId
        self.name = name
        self.ingredients = ingredients
        self.allergens = allergens
        self.barCode = barcode
        self.imageUrlString = imageUrlString
    }
}
