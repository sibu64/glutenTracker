//
//  IngredientListView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

// tableView to show ingredients (DetailsViewController)
class IngredientListView: UITableView {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    private var collection = [String]()
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.dataSource = self
    }
    
    func setUp(ingredients: [String]) {
        self.collection = ingredients
        self.reloadData()
    }
}

// tableView's dataSource
extension IngredientListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    } 

// tableView's delegate
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.ingredientsCellIdentifier, for: indexPath) as! IngredientCell
        let title = collection[indexPath.row]
        cell.mainView?.setUp(with: title)
        return cell
    }
}

extension IngredientListView: UITableViewDelegate {}


