//
//  IngredientCell.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

//Class to show ingredient's cell
class IngredientCell: UITableViewCell {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var mainView: IngredientViewCell?
}
// Class to show IngredientViewCell
class IngredientViewCell: UIView {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var titleLabel: UILabel!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    func setUp(with title: String) {
        self.titleLabel!.text = title.firstUppercased
    }
}

extension String {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }

}
