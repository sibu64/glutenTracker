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
    
    func fetch(completion: @escaping (([CKRecord]?, Error?) ->Void)) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Product", predicate: predicate)
        query.sortDescriptors = [
            NSSortDescriptor(key: "modificationDate", ascending: false)
        ]
        
        database?.perform(query, inZoneWith: nil, completionHandler: completion)
    }
}
