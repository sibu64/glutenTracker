//
//  UIViewController+Extension.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 23/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

// some alerts in case of error and a general case
extension UIViewController {
    func showError() {
        self.showError("An error has occured!")
    }
    
    func showError(_ message: String) {
        UIAlertWrapper.presentAlert(title: "Warning!", message: message, cancelButtonTitle: "Ok")
    }
    
    func showAlert(title: String, message: String) {
        UIAlertWrapper.presentAlert(title: title, message: message, cancelButtonTitle: "Ok")
    }
}
