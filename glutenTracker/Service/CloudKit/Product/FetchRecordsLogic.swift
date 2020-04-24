//
//  FetchRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 16/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

// Class which contains the fetch's logic
class FetchRecordsLogic {
    let service: CloudKitService?

//Initialization of the service CloudKitService
    init(service: CloudKitService? = nil) {
        self.service = service
    }
//Method fetching the records
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
// Completion handler
public typealias GTResultProductsHandler = (Result<[Product], Error>) ->Void

// Default use
extension FetchRecordsLogic {
    public static var `default`: FetchRecordsLogic = {
        let service = CloudKitService()
        return FetchRecordsLogic(service: service)
    }()
}
