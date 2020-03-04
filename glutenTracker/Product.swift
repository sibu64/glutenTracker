//
//  Product.swift
//  FoodTracker
//
//  Created by Darrieumerlou on 11/05/2018.
//  Copyright © 2018 Darrieumerlou. All rights reserved.
//

import Foundation

class ProductViewModel {
    private(set) var model: Product
    
    init(model: Product) {
        self.model = model
    }
    
    var name: String {
        return model.name ?? "Unknown Product"
    }
    
    var glutenLabel: String {
        guard let value = model.isGlutenFree else {
            return "Gluten free: This information is not available"
        }
        return "Gluten free: \(value == true ? "Yes" : "No")"
    }
}

struct Product {
    let objectId: String?
    let name: String?
    let ingredients: [String]?
    let allergens: String?
    let barCode: String?
    let imageUrlString: String?
    private let allergensTags: [String]?
    var isGlutenFree: Bool? {
        guard let value = allergensTags?.contains("en:gluten") else {
            return nil
        }
        return !value
    }
    var imageUrl: URL? {
        if let string = imageUrlString {
           return URL(string: string)
        }
        return nil
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
        let name = json["product_name_fr"] as? String
        let imageUrlString = json["image_front_url"] as? String
        let ingredients = json["ingredients_ids_debug"] as? [String]
        let allergens = json["allergens"] as? String
        let barcode = json["code"] as? String
        let allergensTags = json["allergens_tags"] as? [String]
        
        self.objectId = objectId
        self.name = name
        self.ingredients = ingredients
        self.allergens = allergens
        self.barCode = barcode
        self.imageUrlString = imageUrlString
        self.allergensTags = allergensTags
    }
}
