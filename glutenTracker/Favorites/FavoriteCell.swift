//
//  FavoriteCell.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 18/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteCell: UICollectionViewCell {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
    }

    @discardableResult
    func set(_ model: Product) ->Self {
        self.titleLabel.text = model.name
        self.pictureImageView.kf.indicatorType = .activity
        self.pictureImageView.kf.setImage(with: model.imageUrl)
        return self
    }
}
