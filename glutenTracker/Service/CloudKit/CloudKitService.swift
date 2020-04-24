//
//  CloudKitService.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 05/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

// class wich implements methods to save, fetch, get, delete and delete all the products.
class CloudKitService {
    private(set) var database: CKDatabase?
    
    init(database: CKDatabase? = CKContainer.default().privateCloudDatabase) {
        self.database = database
    }
    
    func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) ->Void)) {
        database?.save(record, completionHandler: completion)
    }
    
//    func updateProfile(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) ->Void)) {
//        let modify = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
//        modify.savePolicy = .allKeys
//        modify.qualityOfService = .userInitiated
//        modify.modifyRecordsCompletionBlock = { savedRecords, _, error in
//            completion(savedRecords?.first, error)
//        }
//        database?.add(modify)
//    }
    
//    func fetchProfile(completion: @escaping (([CKRecord]?, Error?) ->Void)) {
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Profile", predicate: predicate)
//        database?.perform(query, inZoneWith: nil, completionHandler: completion)
//    }
    
    func fetch(completion: @escaping (([CKRecord]?, Error?) ->Void)) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        query.sortDescriptors = [
            NSSortDescriptor(key: "modificationDate", ascending: false)
        ]
        
        database?.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
//    func getProfile(by email: String,  completion: @escaping (([CKRecord]?, Error?) ->Void)) {
//        let predicate = NSPredicate(format: "email = %@", email)
//        let query = CKQuery(recordType: "Profile", predicate: predicate)
//
//        database?.perform(query, inZoneWith: nil, completionHandler: completion)
//    }
    
    func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) ->Void)) {
        let predicate = NSPredicate(format: "objectId = %@", objectId)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        
        database?.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func delete(record: CKRecord, completion: @escaping ((CKRecord.ID?, Error?) ->Void)) {
        database?.delete(withRecordID: record.recordID, completionHandler: completion)
    }
    
    func deleteAll(completion: @escaping ((CKRecordZone.ID?, Error?)->Void)) {
        database?.delete(withRecordZoneID: CKRecordZone.default().zoneID, completionHandler: completion)
    }
}
