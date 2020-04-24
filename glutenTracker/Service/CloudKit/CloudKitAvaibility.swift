//
//  CloudKitAvailability.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

// Structure wich verify CloudKitAvailability
public struct CloudKitAvailability {
    public static func checkIfAvailable(success: (()->Void)?, failure: ((Error)->Void)?) {
        CKContainer.default().accountStatus { status, error in
            DispatchQueue.main.async {
                guard let err = error else {
                    if case .available = status {
                        success?()
                        return
                    }
                    let error = NSError(domain: "darrieumerlou.com", code: 400, userInfo: [NSLocalizedDescriptionKey: "User is not connected to iCloud. Please sign in to iCloud first."])
                    failure?(error)
                    return
                }
                failure?(err)
            }
        }
    }
}
