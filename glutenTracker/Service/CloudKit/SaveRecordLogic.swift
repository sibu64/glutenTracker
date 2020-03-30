//
//  SaveRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 16/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

class SaveRecordLogic {
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

extension SaveRecordLogic {
    public static var `default`: SaveRecordLogic = {
        let service = CloudKitService()
        return SaveRecordLogic(service: service)
    }()
}
