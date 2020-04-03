//
//  SignInWithApple.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 25/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
import AuthenticationServices

public class SignInWithApple {
    init() {}
    
    func isConnected(_ completion: ((Bool)->Void)?) {
        let provider = ASAuthorizationAppleIDProvider()
        
        guard let userId = Credential.retrieveUserId() else {
            completion?(false)
            return
        }
        
        provider.getCredentialState(forUserID: userId) { (credentialState, error) in
            OperationQueue.main.addOperation {
                switch (credentialState){
                case .authorized:
                    completion?(true)
                case .revoked, .notFound:
                    completion?(false)
                default: break
                }
            }
        }
    }
}
