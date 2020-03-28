//
//  LoginVC.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 13/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import AuthenticationServices
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    var fbLoginSuccess = false

    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    
    @IBOutlet weak var stackView: UIStackView!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
        stackView.addArrangedSubview(button)
        
        let fbButton = FBLoginButton(permissions: [ .publicProfile, .email ])
        
        stackView.addArrangedSubview(fbButton)
        
        if let accessToken = AccessToken.current{
            print("User is already logged in")
            print(accessToken)
        }
        
        fbButton.delegate = self
        func loginButton(_: FBLoginButton, result: LoginResult, error: Error){
            print("User logged in")
            switch result {
            case .failed(let error):
                print(error)
                let alert = UIAlertController(title: "The connection has failed", message: "Try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
                self.present(alert, animated: true)
                break
            case .cancelled:
                print("cancelled")
                let alert = UIAlertController(title: "The connection has been cancelled", message: "Try again", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
                self.present(alert, animated: true)
            case .success(let grantedPermissions,_,_):
                print("Login succeeded with granted permissions: \(grantedPermissions)")
                fbLoginSuccess = true
                self.performSegue(withIdentifier: "show", sender: self)
        }
    }
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            print("User logged out")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @objc func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self
        controller.performRequests()
    }
//    func addOberserverForAppleIdChangeNotification(){
//        NotificationCenter.default.addObserver(self, selector: #selector(appleIDStateChanged), name: NSNotification.Name.AccessTokenDidChange, object: nil) //ASAuthorizationAppleIDProviderCredentialRevoked, object: nil)
//    }
    
    @objc func appleIDStateChanged(){
        
    }
    
    func appleLogout(){
        
    }
    
}
extension LoginViewController: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
        let alert = UIAlertController(title: "Bad credentials", message: "It's needed to put the right credentials", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            Credential.save(email: credential.email, and: credential.user)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!//mettre un guard
    }
}
