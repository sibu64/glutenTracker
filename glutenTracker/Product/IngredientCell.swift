//
//  IngredientCell.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var mainView: IngredientViewCell?
}

class IngredientViewCell: UIView {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var titleLabel: UILabel?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    func setUp(with title: String) {
        self.titleLabel?.text = title
    }
}
