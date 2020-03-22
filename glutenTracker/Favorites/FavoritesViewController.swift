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
    //var models: [Product]!
    var cloudKitService: CloudKitService?
    var Ids: [CKRecord.ID]!
     override func viewDidLoad() {
        super.viewDidLoad()
        
        self.listView?.didSelect({ model in
            self.performSegue(
                withIdentifier: Segue.productSegue,
                sender: model
            )
        }).didDelete({ model in
           // self.delete(with: model)
            self.presentAlertForDeleting(with: model)
        })
        
        load()
    }
    
    private func load() {
        FetchRecordsLogic.default.run { result in
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

    @IBAction func deleteAllFavorites(_ sender: Any) {
        let onComplete: (() -> ())? = nil
        //self.deleteAll(ids: recordIds, onComplete: onComplete)
        self.cloudKitService?.deleteAll(ids: cloudKitService!.recordIDs){
            print("records daleted")
            onComplete!()
        }
    }
    
    func presentAlertForDeleting(with model: Product) {
        let alert = UIAlertController(title: "Warning!", message: "Do you really want to delete this favorite?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Yes", style: .cancel, handler: {(action: UIAlertAction!) in DeleteRecordLogic.default.run(model, completion: nil)})
        
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        present(alert, animated: true)
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
    
    private func delete(with model: Product) {
        DeleteRecordLogic.default.run(model) { result in
            switch result {
            case .success(_):
                print("🔥 SUCCESS")
            case .failure(let error):
                print("ERROR: \(error)")
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
