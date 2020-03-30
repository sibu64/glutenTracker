//
//  Fake.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 11/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit
@testable import glutenTracker

extension Product {
    static var fake: Product {
        return Product(
            objectId: "10",
            name: "name",
            ingredients: ["lemon"],
            allergens: "milk",
            barCode: "123",
            imageUrlString: "https://icons.fr",
            allergensTags: ["tags"]
        )
    }
}

extension NSError {
    static var fake: NSError {
        return NSError(domain: "com.simon", code: 10, userInfo: [NSLocalizedDescriptionKey: "error"])
    }
}

class StubCloudKitServiceFailure: CloudKitService {
    override func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) -> Void)) {
        completion(nil, NSError.fake)
    }
    
    override func fetch(completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        completion(nil, NSError.fake)
    }
    
    override func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        completion(nil, NSError.fake)
    }
    
    override func deleteAll(completion: @escaping ((CKRecordZone.ID?, Error?) -> Void)) {
        completion(nil, NSError.fake)
    }
}

class StubCloudKitServiceSuccess: CloudKitService {
    var record: CKRecord? = nil
    
    override func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) -> Void)) {
        completion(Product.fake.toOffline, nil)
    }
    
    override func fetch(completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        completion([Product.fake.toOffline], nil)
    }
    
    override func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        let value = record != nil ? [record!] : []
        completion(value, nil)
    }
    
    override func deleteAll(completion: @escaping ((CKRecordZone.ID?, Error?) -> Void)) {
        let value = CKRecordZone.ID(zoneName: "zone", ownerName: "owner")
        completion(value, nil)
    }
}

class MockCloudKitService: CloudKitService {
    private(set) var record: CKRecord? = nil
    // Save
    private(set) var saveCountCalled = 0
    // Get
    private(set) var getCountCalled = 0
    private(set) var objectId: String? = nil
    // Delete
    private(set) var deleteCountCalled = 0
    // Delete All
    private(set) var deleteAllCountCalled = 0
    // Fetch
    private(set) var fetchCountCalled = 0
    
    override func save(_ record:    CKRecord, completion: @escaping ((CKRecord?, Error?) -> Void)) {
        self.saveCountCalled += 1
        self.record = record
    }
    
    override func fetch(completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        self.fetchCountCalled += 1
    }
    
    override func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        self.getCountCalled += 1
        self.objectId = objectId
    }
    
    override func delete(record: CKRecord, completion: @escaping ((CKRecord.ID?, Error?) -> Void)) {
        self.deleteCountCalled += 1
        self.record = record
    }
    
    override func deleteAll(completion: @escaping ((CKRecordZone.ID?, Error?) -> Void)) {
        self.deleteAllCountCalled += 1
    }
}

class FakeDeleteRecordSuccessService: CloudKitService {
    override func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        completion([Product.fake.toOffline], nil)
    }
    
    override func delete(record: CKRecord, completion: @escaping ((CKRecord.ID?, Error?) -> Void)) {
        let value = CKRecord.ID(recordName: "recordName")
        completion(value, nil)
    }
}

class FakeDeleteRecordFailureService: CloudKitService {
    override func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) -> Void)) {
        completion([Product.fake.toOffline], nil)
    }
    
    override func delete(record: CKRecord, completion: @escaping ((CKRecord.ID?, Error?) -> Void)) {
        completion(nil, NSError.fake)
    }
}

