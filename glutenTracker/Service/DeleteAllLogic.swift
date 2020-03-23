//
//  DeleteAllLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 23/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class DeleteAllLogic {
    private(set) var service: CloudKitService?

    init(service: CloudKitService? = nil) {
        self.service = service
    }

    func run(completion: GTResultVoidHandler?) {
        self.service?.deleteAll(completion: { zoneId, error in
            guard let err = error else {
                completion?(.success(()))
                return
            }
            completion?(.failure(err))
        })
    }
}

extension DeleteAllLogic {
    public static var `default`: DeleteAllLogic = {
        let service = CloudKitService()
        return DeleteAllLogic(service: service)
    }()
}
