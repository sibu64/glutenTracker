//
//  FooterButtonView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 04/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

//Class to manage the three buttons of the GlutenTrackerViewController (scan, details and favorite buttons)
class FooterButtonView: UIStackView {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var scanButton : UIButton!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    // Properties
    public enum Favorite: String {
        case add = "add-favorite", remove = "remove-favorite"
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
    // Setting up the image for the favorite button according to the actions (add or remove)
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
    
    // Setting up the show's action for details button
    func showDetailButton(_ value: Bool) {
        detailButton?.isHidden = !value
    }
    
    // Setting up the show's action for favorite button
    func showFavoriteButton(_ value: Bool, favoriteType: Favorite) {
        self.favoriteButton?.isHidden = !value
        favoriteButton.titleLabel?.textAlignment = .center
        self._favoriteType = favoriteType
    }
}
