//
//  MyTabBarController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 18/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

//Controller to show MyTabBarController
class MyTabBarController: UITabBarController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Reference to GlutenTrackerViewController
    var homeViewController: GlutenTrackerViewController? {
        let navigation = viewControllers?.first as? UINavigationController
        return navigation?.children.first as? GlutenTrackerViewController
    }
    // Reference to FavoritesViewController
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
        
        // Change button image when product has been deleted
        favoriteViewController?.didDelete({ model in
            self.homeViewController?.deletedProduct(model)
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // PerformSegue to MyTabBarController if it's the first launch
        if OnboardingLogic.default.isFirstLaunch {
            self.performSegue(withIdentifier: .showOnboardingSegue, sender: nil)
            return
        }
        
        // Verify if CloudKit is available
        CloudKitAvailability.checkIfAvailable(success: {
        }, failure: { error in
            self.showError(error.localizedDescription)
        })
        
        // Updating GlutenTrackerViewController and the button (to delete all the favorites) when all products are deleted
        favoriteViewController?.didDeleteAll({
            self.homeViewController?.deletedAllProducts()
            self.favoriteViewController?.buttonDeleteFavorites.isEnabled = false
        })
    }

    // Appaearance of TabBarItem
    func barItemAppereance(){
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 15)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Copperplate", size: 15)!], for: .selected)
    }
}


