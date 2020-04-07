////
////  LoginVC.swift
////  glutenTracker
////
////  Created by Darrieumerlou on 13/02/2020.
////  Copyright © 2020 Darrieumerlou. All rights reserved.
////
//
//import UIKit
//import AuthenticationServices
//
//class LoginViewController: UIViewController {
//    // ***********************************************
//    // MARK: - Interface
//    // ***********************************************
//    @IBOutlet weak var stackView: UIStackView!
//    // ***********************************************
//    // MARK: - Implementation
//    // ***********************************************
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Apple
//        let button = ASAuthorizationAppleIDButton()
//        button.addTarget(self, action: #selector(signInWithApple), for: .touchUpInside)
//        stackView.addArrangedSubview(button)
//
//        // Facebook
//        let loginButton = FBLoginButton()
//        loginButton.permissions = ["public_profile", "email"]
//        loginButton.center = view.center
//        loginButton.delegate = self
//        stackView.addArrangedSubview(loginButton)
//
//        //fbButton.delegate = self
////        func loginButton(_: FBLoginButton, result: LoginResult, error: Error){
////            print("User logged in")
////            switch result {
////            case .failed(let error):
////                print(error)
////                let alert = UIAlertController(title: "The connection has failed", message: "Try again", preferredStyle: .alert)
////                alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
////                self.present(alert, animated: true)
////                break
////            case .cancelled:
////                print("cancelled")
////                let alert = UIAlertController(title: "The connection has been cancelled", message: "Try again", preferredStyle: .alert)
////                alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
////                self.present(alert, animated: true)
////            case .success(let grantedPermissions,_,_):
////                print("Login succeeded with granted permissions: \(grantedPermissions)")
////                fbLoginSuccess = true
////                self.performSegue(withIdentifier: "show", sender: self)
////                //present(myTabbarController, animated: true, completion: nil)
////        }
////    }
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    // ***********************************************
//    // MARK: - Actions
//    // ***********************************************
//    @objc func signInWithApple() {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self as ASAuthorizationControllerDelegate
//        controller.presentationContextProvider = self
//        controller.performRequests()
//    }
//}
//
//// ***********************************************
//// MARK: - Facebook Authentication
//// ***********************************************
//extension LoginViewController: LoginButtonDelegate {
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        guard error != nil else {
//            FacebookService().getData(success: { data in
//                print(data)
//            }, failure: { error in
//                print(error)
//            })
//            return
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        print("Facebook Logout: \(loginButton)")
//    }
//}
//// ***********************************************
//// MARK: - APPLE Authentication
//// ***********************************************
//extension LoginViewController: ASAuthorizationControllerDelegate {
//    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print(error)
//        let alert = UIAlertController(title: "Bad credentials", message: "It's needed to put the right credentials", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "I have understood", style: .default, handler: nil))
//        self.present(alert, animated: true)
//    }
//
//
//    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            Credential.save(email: credential.email, and: credential.user)
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//}
//extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
//    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return self.view.window!//mettre un guard
//    }
//}
//
//struct FacebookData {
//    let fbId:String
//    let email:String
//    let firstname:String
//    let lastname:String
//}
//
//
//class FacebookService {
//
//    func getData(success: ((FacebookData)->Void)?, failure: ((Error)->Void)?) {
//        if AccessToken.current != nil {
//            let request = GraphRequest(graphPath: "me", parameters: ["fields":"email, first_name, last_name"])
//            _ = request.start { (_, result, error) in
//
//                guard let err = error else {
//                    if let rst = result {
//                        guard let email = (rst as AnyObject).value(forKey: "email") as? String,
//                            let fbId = (rst as AnyObject).value(forKey: "id") as? String
//                        else {
//                            print("Error")
//                            return
//                        }
//
//                        let firstname = (rst as AnyObject).value(forKey: "first_name") as! String
//                        let lastname = (rst as AnyObject).value(forKey: "last_name") as! String
//
//                        let data = FacebookData(fbId: fbId, email: email, firstname: firstname, lastname: lastname)
//                        success?(data)
//                    }
//                    return
//                }
//                failure?(err)
//            }
//        }
//    }
//}
