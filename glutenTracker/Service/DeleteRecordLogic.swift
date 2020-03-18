//
//  DeleteRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 17/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

class DeleteRecordLogic {
    
var recordIDs = [CKRecord.ID]()

let service: CloudKitService?

init(service: CloudKitService? = nil) {
    self.service = service
}

    func delete(_ record: CKRecord, completion: @escaping ((CKRecord.ID?, Error?) ->Void)) {
        _ = recordIDs.first!
    service?.delete(record) { (deletedRecordID, error) in
               
               if error == nil {
                   
                   print("Record Deleted")
                   
               } else {
                   
                   print("Record Not Deleted")
                   
               }
               
           }
           
       }
}
//public typealias GTResultVoidHandler = (Result<Void, Error>) ->Void

extension DeleteRecordLogic {
    public static var `default`: DeleteRecordLogic = {
        let service = CloudKitService()
        return DeleteRecordLogic(service: service)
    }()
}
