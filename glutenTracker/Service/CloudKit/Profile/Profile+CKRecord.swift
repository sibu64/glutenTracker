//
//  Profile+CKRecord.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 01/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import CloudKit

//extension Profile {
//    public func toOffline(with id: CKRecord.ID) -> CKRecord {
//        let record = CKRecord(recordType: "Profile", recordID: id)
//        record.setValue(self.email, forKey: "email")
//        record.setValue(self.firstname, forKey: "firstname")
//        record.setValue(self.lastname, forKey: "lastname")
//        return record
//    }
//
//    public var toOffline: CKRecord {
//        let record = CKRecord(recordType: "Profile")
//        record.setValue(self.email, forKey: "email")
//        record.setValue(self.firstname, forKey: "firstname")
//        record.setValue(self.lastname, forKey: "lastname")
//        return record
//    }
//}
//
//extension Profile {
//    convenience init?(with record: CKRecord) {
//        guard record.recordType == "Profile" else { return nil }
//        self.init(
//            firstname: record["firstname"] as! String,
//            lastname: record["lastname"] as! String,
//            email: record["email"])
//    }
//}
