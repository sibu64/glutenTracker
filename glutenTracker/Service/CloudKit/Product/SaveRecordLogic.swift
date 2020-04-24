//
//  SaveRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 16/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

// Class which contains the logic of the save's feature for the favorites
class SaveRecordLogic {
    let service: CloudKitService?
    
//Initialization of the service CloudKitService
    init(service: CloudKitService? = nil) {
        self.service = service
    }
    // method converting a product to a record and save it
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

//Completion Handler
public typealias GTResultVoidHandler = (Result<Void, Error>) ->Void

// Default use
extension SaveRecordLogic {
    public static var `default`: SaveRecordLogic = {
        let service = CloudKitService()
        return SaveRecordLogic(service: service)
    }()
}
