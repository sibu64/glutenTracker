//
//  FooterButtonView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 04/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class FooterButtonView: UIStackView {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var scanButton : UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    // Properties
    public enum Favorite: String {
        case add = "plus", remove = "minus"
    }
    private var _favoriteType: Favorite = .add
    public var favoriteType: Favorite {
        return _favoriteType
    }
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func awakeFromNib() {
        super.awakeFromNib()
        scanButton.layer.cornerRadius = 25
        detailButton.layer.cornerRadius = 25
        favoriteButton.layer.cornerRadius = 25
        
        self.showDetailButton(false)
        self.showFavoriteButton(false, favoriteType: .add)
        self.setFavoriteTitle(value: .add)
    }
    
    func setFavoriteTitle(value: Favorite) {
        switch value {
        case .add:
            let image = UIImage(named: "add-favorite")
            self.favoriteButton.setImage(image, for: .normal)
        case .remove:
            let image = UIImage(named: "remove-favorite")
            self.favoriteButton.setImage(image, for: .normal)
        }
    }
    
    func showDetailButton(_ value: Bool) {
        detailButton?.isHidden = !value
    }
    
    func showFavoriteButton(_ value: Bool, favoriteType: Favorite) {
        self.favoriteButton?.isHidden = !value
        favoriteButton.titleLabel?.textAlignment = .center
        self._favoriteType = favoriteType
    }
}
