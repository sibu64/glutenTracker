//
//  UIViewController+Extension.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 23/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(_ message: String) {
        UIAlertWrapper.presentAlert(title: "Warning!", message: "An error has occured!", cancelButtonTitle: "Ok")
    }
}
