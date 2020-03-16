//
//  Product+CKRecord.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 16/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

extension Product {
    public var toOffline: CKRecord {
        let record = CKRecord(recordType: "Product")
        record.setValue(self.name, forKey: "name")
        record.setValue(self.objectId, forKey: "objectId")
        record.setValue(self.barCode, forKey: "barCode")
        record.setValue(self.imageUrlString, forKey: "imageUrlString")
        record.setValue(self.allergens, forKey: "allergens")
        record.setValue(self.ingredients, forKey: "ingredients")
        record.setValue(self.allergensTags, forKey: "allergensTags")
        return record
    }
}

extension Product {
    init?(with record: CKRecord) {
        guard record.recordType == "Product" else { return nil }
        self.init(
            objectId: record["objectId"],
            name: record["name"],
            ingredients: record["ingredients"],
            allergens: record["allergens"],
            barCode: record["barCode"],
            imageUrlString: record.value(forKey: "imageUrlString") as? String,
            allergensTags: record["allergensTags"]
        )
    }
}

extension Array where Element == CKRecord {
    public var toModels: [Product]? {
        return self.compactMap { Product(with: $0) }
    }
}
