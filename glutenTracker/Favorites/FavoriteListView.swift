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
    private var collection = [ProductViewModel]()
    private var didSelect: ((ProductViewModel)->Void)?
    private var didDelete: ((ProductViewModel, IndexPath)->Void)?
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
    
    func set(_ collection: [ProductViewModel]) {
        self.collection = collection
        self.reloadData()
    }
    
    func didSelect(_ completion: ((ProductViewModel)->Void)?) {
        self.didSelect = completion
    }
    
    func didDelete(_ completion: ((ProductViewModel, IndexPath)->Void)?) {
        self.didDelete = completion
    }
    
    func deleteRow(at indexPath: IndexPath) {
        self.collection.remove(at: indexPath.item)
        self.deleteItems(at: [indexPath])
    }
    
    func deleteAll() {
        self.collection.removeAll()
        self.reloadData()
    }
}

extension FavoriteListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: Identifier.favoriteCellIdentifier, for: indexPath) as! FavoriteCell
        let model = self.collection[indexPath.row]
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
