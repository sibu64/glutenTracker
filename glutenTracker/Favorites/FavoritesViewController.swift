//
//  FavoritesViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 20/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

class FavoritesViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("Favorites")
    }
    
    private let reuseIdentifier = "FavoriteCell"
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
    left: 20.0,
    bottom: 50.0,
    right: 20.0)
    
    private var searches = CKRecord(recordType: "Product")
    
}
    
    
    
    
    
    
    
    extension FavoritesViewController {
      //1
      override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
      }
      
      //2
      override func collectionView(_ collectionView: UICollectionView,
                                   numberOfItemsInSection section: Int) -> Int {
        return searches.allTokens().count
      }
      
      //3
      override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
      ) -> UICollectionViewCell {
        let cell = collectionView
          .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        //cell.
        return cell
      }
    }
    

