//
//  FavoriteListView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 18/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class FavoriteListView: UICollectionView {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet var placeholderView: UIView!
    // Properties
    private var didSelect: ((Product)->Void)?
    private var didDelete: ((Product, IndexPath)->Void)?
    var collection = [Product]() {
        didSet {
            self.backgroundView = self.collection.isEmpty == true ?
                placeholderView : nil
        }
    }
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        
        let nib = UINib(nibName: Identifier.favoriteCellIdentifier, bundle: Bundle.main)
        self.register(nib, forCellWithReuseIdentifier: Identifier.favoriteCellIdentifier)
    }
    
    func set(_ collection: [Product]) {
        self.collection = collection
        self.reloadData()
    }
    
    // Completion handler for select
    func didSelect(_ completion: ((Product)->Void)?) {
        self.didSelect = completion
    }
    
    // Completion handler for delete
    func didDelete(_ completion: ((Product, IndexPath)->Void)?) {
        self.didDelete = completion
    }
    
    // Function to delete row
    func deleteRow(at indexPath: IndexPath) {
        self.collection.remove(at: indexPath.item)
        self.deleteItems(at: [indexPath])
    }
    
    // Function to delete all the favorites
    func deleteAll() {
        self.collection.removeAll()
        self.reloadData()
    }

}

extension FavoriteListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: Identifier.favoriteCellIdentifier, for: indexPath) as! FavoriteCell
        let model = collection[indexPath.row]
        cell.set(model)
        cell.didDelete { item in
            self.didDelete?(item, indexPath)
        }
        return cell
    }
}

extension FavoriteListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.collection[indexPath.row]
        self.didSelect?(model)
    }
}
