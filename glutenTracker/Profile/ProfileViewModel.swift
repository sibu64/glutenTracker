//
//  ProfileViewModel.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 07/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class ProfileViewModel {
    var firstname: String?
    var lastname: String?
    var email: String?
    
    var isValid: Bool {
        return firstname?.isEmpty == false &&
            lastname?.isEmpty == false &&
            email?.isValidEmail == true
    }
    
    init() {}
    
    convenience init(firstname: String?, lastname: String?, email: String?) {
        self.init()
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
}

extension Profile {
    var toViewModel: ProfileViewModel {
        return ProfileViewModel(
            firstname: self.firstname,
            lastname: self.lastname,
            email: self.email
        )
    }
}

extension ProfileViewModel {
    public var toModel: Profile {
        return Profile(firstname: self.firstname, lastname: self.lastname, email: self.email)
    }
}
