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
    var recordIDs = [CKRecord.ID]()
    
    init(database: CKDatabase? = CKContainer.default().privateCloudDatabase) {
        self.database = database
    }
    
    func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) ->Void)) {
        database?.save(record, completionHandler: completion)
    }
    
    func fetch(completion: @escaping (([CKRecord]?, Error?) ->Void)) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        query.sortDescriptors = [
            NSSortDescriptor(key: "modificationDate", ascending: false)
        ]
        
        database?.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func get(by objectId: String, completion: @escaping (([CKRecord]?, Error?) ->Void)) {
        let predicate = NSPredicate(format: "objectId = %@", objectId)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        
        database?.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func delete(record: CKRecord, completion: @escaping ((CKRecord.ID?, Error?) ->Void)) {
        print("🦄 \(record.recordID)")
        database?.delete(withRecordID: record.recordID, completionHandler: completion)
    }
    
    
    
    
    
    private var onAllQueriesCompleted : (()->())?
    public var resultsLimit = 100
    private var recordIDsToDelete = [CKRecord.ID]()

    func delete(query: CKQuery, onComplete: @escaping ()->Void) {
           onAllQueriesCompleted = onComplete
           add(queryOperation: CKQueryOperation(query: query))
       }

       private func add(queryOperation: CKQueryOperation) {
           queryOperation.resultsLimit = resultsLimit
           queryOperation.queryCompletionBlock = queryDeleteCompletionBlock
           queryOperation.recordFetchedBlock = recordFetched
           database?.add(queryOperation)
       }

    private func queryDeleteCompletionBlock(cursor: CKQueryOperation.Cursor?, error: Error?) {
           print("-----------------------")
           deleteAll(ids: recordIDsToDelete) {
               self.recordIDsToDelete.removeAll()

               if let cursor = cursor {
                   self.add(queryOperation: CKQueryOperation(cursor: cursor))
               } else {
                   self.onAllQueriesCompleted?()
               }
           }
       }

        func recordFetched(record: CKRecord) {
           print("RECORD fetched: \(record.recordID.recordName)")
           recordIDsToDelete.append(record.recordID)
       }

     func deleteAll(ids: [CKRecord.ID], onComplete: @escaping ()->()) {
           let delete = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: ids)
           delete.completionBlock = {
               onComplete()
           }
        database?.add(delete)
       }
    }
