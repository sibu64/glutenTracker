//
//  DeleteRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 17/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

// Class which contains the logic of the delete's feature for the favorites
 class DeleteRecordLogic {
    private(set) var service: CloudKitService?

// Initialization of the service CloudKitService
    init(service: CloudKitService? = nil) {
        self.service = service
    }

// Method deleting the record
    func run(_ model: Product, completion: GTResultVoidHandler?) {
        self.service?.get(by: model.objectId!, completion: { records, error in
            guard let record = records?.first else { return }
            self.service?.delete(record: record, completion: { recordId, error in
                guard let err = error else {
                    completion?(.success(()))
                    return
                }
                completion?(.failure(err))
            })
        })
    }

// Method deleting all the records
func runDeleteAll(completion: GTResultVoidHandler?) {
            self.service?.deleteAll(completion: { zoneId, error in
                guard let err = error else {
                    completion?(.success(()))
                    return
                }
                completion?(.failure(err))
            })
        }
    }

//Default use
    extension DeleteRecordLogic {
    public static var `default`: DeleteRecordLogic = {
        let service = CloudKitService()
        return DeleteRecordLogic(service: service)
    }()
}
