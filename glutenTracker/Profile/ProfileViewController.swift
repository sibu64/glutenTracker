//
//  ProfileViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 24/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

// Class managing the profile (feature in progress...)
class ProfileViewController: UITableViewController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Fullname of the user
    @IBOutlet weak var firstAndLastname: UILabel!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func loadView() {
        super.loadView()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileFirstnameAndLastname()
    }
    
    // Method to retrieve the fullname of the user
    @discardableResult
    func getProfileFirstnameAndLastname()->String {
        CKContainer.default().requestApplicationPermission(.userDiscoverability) { (status, error) in
            CKContainer.default().fetchUserRecordID { (record, error) in
                CKContainer.default().discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userIdentity, error) in
                    DispatchQueue.main.async {
                        self.firstAndLastname.text = ((userIdentity?.nameComponents?.givenName)!) + " " +  (userIdentity?.nameComponents?.familyName)!
                    }
                })
            }
        }
        return firstAndLastname.text!
    }    
}
