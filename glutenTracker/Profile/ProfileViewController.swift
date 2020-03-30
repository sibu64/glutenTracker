//
//  ProfileViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 24/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var appleID: UILabel!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    func retrieveAppleEmail() {
        email.text =  Credential.rerieveUserEmail()
    }
    
    func retrieveAppleID() {
        appleID.text =  Credential.retrieveUserId()
    }
    
    func retrieveFBinformations(){
        Profile.loadCurrentProfile(completion: {
        profile, error in
            _ = profile?.imageURL(forMode: Profile.PictureMode.square, size: self.profileImage.intrinsicContentSize)
            if profile != nil {
                let firstName = Profile.current?.firstName
                let lastName = Profile.current?.lastName
            print("FB user details \(String(describing: firstName))\(String(describing: lastName))")
    }
        }
    )}

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveAppleEmail()
        retrieveAppleID()
        retrieveFBinformations()
    }
    
}

