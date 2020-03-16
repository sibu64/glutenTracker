//
//  FavoritesViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 20/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

class FavoritesViewController: UIViewController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var listView: UICollectionView?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        print("coucou")
        
        FetchRecordLogic.default.run { result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let models):
                models.forEach { model in
                    print(model.name)
                    print(model.isGlutenFree)
                    print("---------------")
                }
            }
        }
    }
    
}
    

