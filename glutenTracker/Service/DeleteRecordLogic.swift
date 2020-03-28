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
    private(set) var service: CloudKitService?

    init(service: CloudKitService? = nil) {
        self.service = service
    }

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

    extension DeleteRecordLogic {
    public static var `default`: DeleteRecordLogic = {
        let service = CloudKitService()
        return DeleteRecordLogic(service: service)
    }()
}
