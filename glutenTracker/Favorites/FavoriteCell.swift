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
    // Properties
    private var viewModel: ProductViewModel?
    private var didDelete: ((ProductViewModel)->Void)?
    lazy var longGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(actionPress(sender:)))
        gesture.minimumPressDuration = 1
        return gesture
    }()
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGestureRecognizer(longGesture)
    }


    func set(_ viewModel: ProductViewModel) {
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.model.name
        self.pictureImageView.kf.indicatorType = .activity
        self.pictureImageView.kf.setImage(with: viewModel.model.imageUrl)
    }
    
    func didDelete(_ completion: ((ProductViewModel)->Void)?) {
        self.didDelete = completion
    }
    
    // ***********************************************
    // MARK: - Action
    // ***********************************************
    @objc func actionPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            guard let value = self.viewModel else { return }
            self.didDelete?(value)
        }
    }
}
