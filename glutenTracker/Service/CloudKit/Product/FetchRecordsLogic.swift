//
//  FetchRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 16/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

class FetchRecordsLogic {
    let service: CloudKitService?
    
    init(service: CloudKitService? = nil) {
        self.service = service
    }
    
    public func run(_ completion: GTResultProductsHandler?) {
        self.service?.fetch(completion: { records, error in
            guard let err = error else {
                let models = records?.toModels ?? []
                completion?(.success(models))
                return
            }
            completion?(.failure(err))
        })
    }
}

public typealias GTResultProductsHandler = (Result<[Product], Error>) ->Void

extension FetchRecordsLogic {
    public static var `default`: FetchRecordsLogic = {
        let service = CloudKitService()
        return FetchRecordsLogic(service: service)
    }()
}
