//
//  MyTabBarController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 18/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    var homeViewController: GlutenTrackerViewController? {
        let navigation = viewControllers?.first as? UINavigationController
        return navigation?.children.first as? GlutenTrackerViewController
    }
    
    var favoriteViewController: FavoritesViewController? {
        let navigation = viewControllers?[1] as? UINavigationController
        return navigation?.children.first as? FavoritesViewController
    }
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        barItemAppereance()
        
        favoriteViewController?.didDelete({ viewModel in
            self.homeViewController?.deletedProduct(viewModel)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if OnboardingLogic.default.isFirstLaunch {
            self.performSegue(withIdentifier: .showOnboardingSegue, sender: nil)
            return
        }
        
        CloudKitAvailability.checkIfAvailable(success: {
            print("🔥 iCloud available")
        }, failure: { error in
            self.showError(error.localizedDescription)
        })
        
        favoriteViewController?.didDeleteAll({
            self.homeViewController?.deletedAllProducts()
            self.favoriteViewController?.buttonDeleteFavorites.isEnabled = false
        })
    }


    func barItemAppereance(){
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 15)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 15)!], for: .selected)
    }
}


