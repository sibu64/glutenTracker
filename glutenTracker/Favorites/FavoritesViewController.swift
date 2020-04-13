//
//  FavoritesViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 20/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

// Controller to show Favorites
class FavoritesViewController: UIViewController {
    
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var listView: FavoriteListView!
    @IBOutlet weak var buttonDeleteFavorites: UIBarButtonItem!
    @IBOutlet weak var noFavoriteMessageLabel: UILabel!
    // Properties
    // Callback for deleted value
    private var didDelete: ((Product)->Void)?
    // Callback for deleted all values
    private var didDeleteAll: (()->Void)?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        // Manage UI
        leftBarButtonItemTintColor()
        enableDeleteAllButton(enabled: false)
        
        // Callback when selected value from ListView
        self.listView.didSelect({ model in
            self.performSegue(
                withIdentifier: .productSegue,
                sender: model
            )
        })
        
        // Callback when deleted value from ListView
        self.listView.didDelete({ model, indexPath in
            self.presentAlert {
                self.delete(with: model) {
                    self.listView.deleteRow(at: indexPath)
                    let enable = !self.listView.collection.isEmpty
                    self.enableDeleteAllButton(enabled: enable)
                    self.didDelete?(model)
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load()
    }
    
    // Expose delete callback to public
    public func didDelete(_ completion: ((Product)->Void)?) {
        self.didDelete = completion
    }
    
    // Expose delete all callback to public
    public func didDeleteAll(_ completion: (()->Void)?) {
        self.didDeleteAll = completion
    }
    
    // Change tint color
    public func leftBarButtonItemTintColor() {
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.systemYellow
    }
    
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    // Load Favorites Products from CloudKit
    private func load() {
        FetchRecordsLogic.default.run { result in
            switch result {
            case .failure(let err):
                DispatchQueue.main.async {
                    self.failure(error: err)
                }
            case .success(let models):
                DispatchQueue.main.async {
                    self.success(models)
                }
            }
        }
    }
    
    // Delete All Favorites Products from CloudKit
    @IBAction func deleteAllFavorites(_ sender: Any) {
        DeleteRecordLogic.default.runDeleteAll { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.listView.deleteAll()
                    self.didDeleteAll?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func presentAlert(success completion: (()->Void)?) {
        UIAlertWrapper.presentAlert(title: "Warning!", message: "Do you really want to delete this favorite?", cancelButtonTitle: "Cancel", otherButtonTitles: ["Ok"]) { index in
            if index == 1 { completion?() }
        }
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    // State for Delete All Button
    private func enableDeleteAllButton(enabled: Bool) {
         self.navigationItem.rightBarButtonItem?.isEnabled = enabled
    }
    
    // Display Error
    private func failure(error: Error) {
        self.showError(error.localizedDescription)
    }
    
    // Display Products
    private func success(_ models: [Product]) {
        self.listView?.set(models)
        self.enableDeleteAllButton(enabled: !models.isEmpty)
    }
    
    // Delete one Favorite Product from CloudKit
    private func delete(with model: Product, success: (()->Void)?) {
        DeleteRecordLogic.default.run(model) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    success?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error.localizedDescription)
                }
            }
        }
    }
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .productSegue {
            let controller = segue.destination as? DetailsViewController
            controller?.model = (sender as? Product)
        }
    }
}
