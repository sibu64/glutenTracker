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
    private var collection = [Product]()
    private var didSelect: ((Product)->Void)?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        
        let nib = UINib(nibName: "FavoriteCell", bundle: Bundle.main)
        self.register(nib, forCellWithReuseIdentifier: "FavoriteCell")
    }
    
    @discardableResult
    func set(_ collection: [Product]) ->Self {
        self.collection = collection
        self.reloadData()
        return self
    }
    
    @discardableResult
    func didSelect(_ completion: ((Product)->Void)?) ->Self {
        self.didSelect = completion
        return self
    }
}

extension FavoriteListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let model = self.collection[indexPath.row]
        cell.set(model)
        return cell
    }
}

extension FavoriteListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.collection[indexPath.row]
        self.didSelect?(model)
    }
}
