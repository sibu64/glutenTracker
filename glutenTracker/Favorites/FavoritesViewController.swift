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
    @IBOutlet weak var listView: FavoriteListView!
    @IBOutlet weak var buttonDeleteFavorites: UIBarButtonItem!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView.didSelect({ model in
            self.performSegue(
                withIdentifier: Segue.productSegue,
                sender: model
            )
        }).didDelete({ model, indexPath in
            self.presentAlert {
                self.delete(with: model) {
                    self.listView.deleteRow(at: indexPath)
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load()
    }
    
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

    @IBAction func deleteAllFavorites(_ sender: Any) {
        DeleteAllLogic.default.run { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.listView.deleteAll()
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
    private func failure(error: Error) {
        self.showError(error.localizedDescription)
    }
    
    private func success(_ models: [Product]) {
        self.listView?.set(models)
    }
    
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
        if segue.identifier == Segue.productSegue {
            let controller = segue.destination as? DetailsViewController
            controller?.product = (sender as? Product)
        }
    }
}
