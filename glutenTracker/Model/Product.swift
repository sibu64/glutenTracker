//
//  Product.swift
//  FoodTracker
//
//  Created by Darrieumerlou on 11/05/2018.
//  Copyright © 2018 Darrieumerlou. All rights reserved.
//

import Foundation

public struct Product: Equatable {
    public let objectId: String?
    public let name: String?
    public let ingredients: [String]?
    public let allergens: String?
    public let barCode: String?
    public let imageUrlString: String?
    public let allergensTags: [String]?
    public var isGlutenFree: Bool? {
        guard let value = allergensTags?.contains("en:gluten") else {
            return nil
        }
        return !value
    }
    public var imageUrl: URL? {
        if let string = imageUrlString {
            return URL(string: string)!
        }
        return self.imageUrl
    }
    
    init(objectId: String?, name: String?, ingredients: [String]?, allergens: String?, barCode: String?, imageUrlString: String?, allergensTags: [String]?) {
        self.objectId = objectId
        self.name = name
        self.ingredients = ingredients
        self.allergens = allergens
        self.barCode = barCode
        self.imageUrlString = imageUrlString
        self.allergensTags = allergensTags
    }
}

extension Product {
    init(json: [String: Any]) {
        let objectId = json["_id"] as? String
        let name = json["product_name"] as? String
        let imageUrlString = json["image_front_url"] as? String
        let ingredients = json["ingredients_text_en"] as? String
        let allergens = json["allergens"] as? String
        let barcode = json["code"] as? String
        let allergensTags = json["allergens_tags"] as? [String]
        
        self.objectId = objectId
        self.name = name
        
        let value = ingredients?.cleanString?.joinedByComma
        self.ingredients = value
        
        self.allergens = allergens?.removeTags
        
        self.barCode = barcode
        self.imageUrlString = imageUrlString
        self.allergensTags = allergensTags
    }
}
