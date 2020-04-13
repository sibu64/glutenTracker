//
//  Profile.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 01/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation


public class Profile: Equatable {
    public var firstname: String?
    public var lastname: String?
    public var email: String?
    
    public var isValid: Bool {
        return firstname?.isEmpty == false &&
            lastname?.isEmpty == false &&
            email?.isValidEmail == true
    }
    
    init(firstname: String?, lastname: String?, email: String?) {
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
    }
    
    convenience init() {
        self.init(firstname: nil, lastname: nil, email: nil)
    }
    
    public static func == (lhs: Profile, rhs: Profile) -> Bool {
        return lhs.firstname == rhs.firstname &&
            lhs.lastname == rhs.lastname &&
            lhs.email == rhs.email
    }
}
