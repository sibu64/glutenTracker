//
//  GetProfileLogic.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 07/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

public class GetProfileLogic {
    let service: CloudKitService?
    
    init(service: CloudKitService? = nil) {
        self.service = service
    }
    
    public func run(completion: GTResultProfileHandler?) {
        service?.fetchProfile(completion: { records, error in
            guard let err = error else {
                guard let record = records?.first,
                    let model = Profile(with: record) else {
                        return
                }
                completion?(.success(model))
                return
            }
            completion?(.failure(err))
        })
    }
}

public typealias GTResultProfileHandler = (Result<Profile, Error>) ->Void

extension GetProfileLogic {
    public static var `default`: GetProfileLogic = {
        let service = CloudKitService()
        return GetProfileLogic(service: service)
    }()
}
