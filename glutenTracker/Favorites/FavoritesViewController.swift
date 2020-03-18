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
    @IBOutlet weak var listView: FavoriteListView?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    //var models: [Product]!
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView?.didSelect({ model in
            self.performSegue(
                withIdentifier: "ProductSegue",
                sender: model
            )
        })
        
        load()
    }
    
    private func load() {
        FetchRecordLogic.default.run { result in
            switch result {
            case .failure(let err):
                OperationQueue.main.addOperation {
                    self.failure(error: err)
                }
            case .success(let models):
                OperationQueue.main.addOperation {
                    self.success(models)
                }
            }
        }
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    private func failure(error: Error) {
        print(error)
    }
    
    private func success(_ models: [Product]) {
        self.listView?.set(models)
    }
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductSegue" {
            let controller = segue.destination as? DetailsViewController
            controller?.product = (sender as? Product)
        }
    }
}

            
