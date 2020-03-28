//
//  MyTabBarController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 18/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        barItemAppereance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SignInWithApple().isConnected { [weak self] success in
            guard success == false else {
                print("Connected")
                return
            }
            self?.performSegue(withIdentifier: "AuthenticationSegue", sender: nil)
        }
    }


func barItemAppereance(){
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 15)!], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 15)!], for: .selected)
}
    

    
}



