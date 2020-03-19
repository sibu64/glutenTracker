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
    
    init(service: CloudKitService? = nil) {
        self.service = service
    }
    
    public func run(with model: Product, completion: GTResultProductHandler?) {
        guard let value = model.objectId else { fatalError("Unknown ObjectId") }
        self.service?.get(by: value, completion: { records, error in
            guard let err = error else {
                guard let record = records?.first,
                    let product = Product(with: record)
                    else { return }
                completion?(.success(product))
                return
            }
            completion?(.failure(err))
        })
    }
}

typealias GTResultProductHandler = (Result<Product, Error>) ->Void

extension GetRecordLogic {
    public static var `default`: GetRecordLogic = {
        let service = CloudKitService()
        return GetRecordLogic(service: service)
    }()
}
