//
//  Profile+CKRecord.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 01/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

extension Profile {
    public var toOffline: CKRecord {
        let record = CKRecord(recordType: "Profile")
        record.setValue(self.email, forKey: "email")
        record.setValue(self.firstname, forKey: "firstname")
        record.setValue(self.lastname, forKey: "lastname")
        record.setValue(self.fbId, forKey: "fbId")
        record.setValue(self.appleId, forKey: "appleId")
        return record
    }
}

extension Profile {
    init(data: FacebookData) {
        self.appleId = nil
        self.fbId = data.fbId
        self.email = data.email
        self.firstname = data.firstname
        self.lastname = data.lastname
    }
}
