//
//  SaveProfileLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 01/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

public class SaveProfileLogic {
    let service: CloudKitService?
    
    init(service: CloudKitService? = nil) {
        self.service = service
    }
    
    public func run(with profile: Profile, completion: GTResultVoidHandler?) {
        service?.getProfile(by: profile.email!, completion: { records, error in
            guard let err = error else {
                guard let savedRecord = records?.first else {
                    self.save(record: profile.toOffline, completion: completion)
                    return
                }
                let record = profile.toOffline(with: savedRecord.recordID)
                self.update(record: record, completion: completion)
                return
            }
            completion?(.failure(err))
        })
    }
    
    private func update(record: CKRecord, completion: GTResultVoidHandler?) {
        service?.updateProfile(record, completion: { record, error in
            guard let err = error else {
                completion?(.success(()))
                return
            }
            completion?(.failure(err))
        })
    }
    
    private func save(record: CKRecord, completion: GTResultVoidHandler?) {
        service?.save(record, completion: { value, error in
           guard let err = error else {
               completion?(.success(()))
               return
           }
           completion?(.failure(err))
       })
    }
}

extension SaveProfileLogic {
    public static var `default`: SaveProfileLogic = {
        let service = CloudKitService()
        return SaveProfileLogic(service: service)
    }()
}
