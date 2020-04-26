//
//  FavoriteCell.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 18/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import Kingfisher

// Class tho show Favorites'cells
class FavoriteCell: UICollectionViewCell {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var isGlutenFreeImageView: UIImageView!
    // Properties
    private var model: Product!
    private var didDelete: ((Product)->Void)?
    lazy var longGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(actionPress(sender:)))
        gesture.minimumPressDuration = 1
        return gesture
    }()
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    // Adding a gesture recognizer
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(longGesture)
    }

    // Setting up the name and the image of the favorite's cell
    func set(_ model: Product) {
        self.model = model
        self.titleLabel.text = model.productName
        if model.isGlutenFree == true {
            self.isGlutenFreeImageView.image = UIImage(named: "gluten-free")
        }
        else{
            self.isGlutenFreeImageView.image = UIImage(named: "gluten")
        }
        self.pictureImageView.kf.indicatorType = .activity
        self.pictureImageView.kf.setImage(with: model.imageUrl)
    }
    
    func didDelete(_ completion: ((Product)->Void)?) {
        self.didDelete = completion
    }
    
    // ***********************************************
    // MARK: - Action
    // ***********************************************
    @objc func actionPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            guard let value = self.model else { return }
            self.didDelete?(value)
        }
    }
}
