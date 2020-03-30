//
//  LoginVC.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 13/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import AuthenticationServices
import FBSDKCoreKit
import FBSDKLoginKit

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
        
       // let fbButton = FBLoginButton(permissions: [ .publicProfile, .email ])
        
        //stackView.addArrangedSubview(fbButton)
        
        if let accessToken = AccessToken.current{
            print("User is already logged in")
            print(accessToken)
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "show" {
                _ = segue.destination as! MyTabBarController
            }
        }
        //fbButton.delegate = self
//        func loginButton(_: FBLoginButton, result: LoginResult, error: Error){
//            print("User logged in")
//            switch result {
//            case .failed(let error):
//                print(error)
//                let alert = UIAlertController(title: "The connection has failed", message: "Try again", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
//                self.present(alert, animated: true)
//                break
//            case .cancelled:
//                print("cancelled")
//                let alert = UIAlertController(title: "The connection has been cancelled", message: "Try again", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
//                self.present(alert, animated: true)
//            case .success(let grantedPermissions,_,_):
//                print("Login succeeded with granted permissions: \(grantedPermissions)")
//                fbLoginSuccess = true
//                self.performSegue(withIdentifier: "show", sender: self)
//                //present(myTabbarController, animated: true, completion: nil)
//        }
//    }
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





import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class FacebookSignInManager: NSObject {
    typealias LoginCompletionBlock = (Dictionary<String, AnyObject>?, NSError?) -> Void
    
    //MARK:- Public functions
    class func basicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        
        //Check internet connection if no internet connection then return
        self.getBasicInfoWithCompletionHandler(fromViewController) { (dataDictionary:Dictionary<String, AnyObject>?, error: NSError?) -> Void in
            onCompletion(dataDictionary, error)
        }
    }
    
    class func logoutFromFacebook() {
        LoginManager().logOut()
        AccessToken.current = nil
        Profile.current = nil
    }
    
    //MARK:- Private functions
    class fileprivate func getBasicInfoWithCompletionHandler(_ fromViewController:AnyObject, onCompletion: @escaping LoginCompletionBlock) -> Void {
        
        let permissionDictionary = [
            "fields" : "id,name,first_name,last_name,gender,email,birthday,picture.type(large)"]
        //"locale” : “en_US”
        //]
        if AccessToken.current != nil {
            GraphRequest.init(graphPath: "/me", parameters: permissionDictionary)
                .start(completionHandler:  { (connection, result, error) in
                if error == nil {
                onCompletion(result as? Dictionary<String, AnyObject>, nil)
                } else {
                onCompletion(nil, error as NSError?)
                }
                })
            
        } else {
            
            LoginManager().logIn(permissions: ["public_profile", "email"], from: LoginViewController() as? UIViewController, handler: {  (result, error) -> Void in
                if error != nil {
                LoginManager().logOut()
                if let error = error as NSError? {
                let errorDetails = [NSLocalizedDescriptionKey : "Processing Error. Please try again!"]
                let customError = NSError(domain: "Error!", code: error.code, userInfo: errorDetails)
                onCompletion(nil, customError)
                } else {
                onCompletion(nil, error as NSError?)
                }
                
                } else if (result?.isCancelled)! {
                LoginManager().logOut()
                let errorDetails = [NSLocalizedDescriptionKey : "Request cancelled!"]
                let customError = NSError(domain: "Request cancelled!", code: 1001, userInfo: errorDetails)
                onCompletion(nil, customError)
                } else {
                    
                let pictureRequest = GraphRequest(graphPath: "me", parameters: permissionDictionary)
                let _ = pictureRequest.start(completionHandler: {
                (connection, result, error) -> Void in
                if error == nil {
                onCompletion(result as? Dictionary<String, AnyObject>, nil)
                
                } else {
                onCompletion(nil, error as NSError?)
                }
                })
                }
                })
                }
    }
               
}
