//
//  GetRecordLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 19/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class GetRecordLogic {
    private(set) var service: CloudKitService?
    
// Initialization of the service CloudKitService
    init(service: CloudKitService? = nil) {
        self.service = service
    }

// Method getting the records
    public func run(with model: Product, completion: GTResultProductHandler?) {
        guard let value = model.objectId else { return }
        self.service?.get(by: value, completion: { records, error in
            guard let err = error else {
                guard let record = records?.first,
                    let product = Product(with: record)
                    else {
                        completion?(.failure(NSError.noData))
                        return
                }
                completion?(.success(product))
                return
            }
            completion?(.failure(err))
        })
    }
}

// Completion handler
typealias GTResultProductHandler = (Result<Product, Error>) ->Void

//Default use
extension GetRecordLogic {
    public static var `default`: GetRecordLogic = {
        let service = CloudKitService()
        return GetRecordLogic(service: service)
    }()
}
