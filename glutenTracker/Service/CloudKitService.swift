//
//  CloudKitService.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 05/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitService {
    private(set) var database: CKDatabase?
    
    init(database: CKDatabase? = CKContainer.default().privateCloudDatabase) {
        self.database = database
    }
    
    func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) ->Void)) {
        database?.save(record, completionHandler: completion)
    }
}


class SaveRecord {
    let service: CloudKitService?
    
    init(service: CloudKitService? = nil) {
        self.service = service
    }
    
    public func run(with model: Product, completion: GTResultVoidHandler?) {
        let record = model.toOffline
        service?.save(record, completion: { ckRecord, error in
            guard let err = error else {
                completion?(.success(()))
                return
            }
            completion?(.failure(err))
        })
    }
}

public typealias GTResultVoidHandler = (Result<Void, Error>) ->Void

extension SaveRecord {
    public static var `default`: SaveRecord = {
        let service = CloudKitService()
        return SaveRecord(service: service)
    }()
}

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
