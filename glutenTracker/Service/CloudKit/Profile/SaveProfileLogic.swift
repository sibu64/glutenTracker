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
        let record = profile.toOffline
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
