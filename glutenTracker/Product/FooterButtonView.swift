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
    public enum Favorite {
        case add, remove
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
        self.setFavoriteTitle(text: "Add to favorites")
    }
    
    @discardableResult
    func setFavoriteTitle(text: String) ->Self {
        self.favoriteButton?.setTitle(text, for: .normal)
        return self
    }
    
    @discardableResult
    func showDetailButton(_ value: Bool) ->Self {
        detailButton?.isHidden = !value
        return self
    }
    
    @discardableResult
    func showFavoriteButton(_ value: Bool, favoriteType: Favorite) ->Self {
        self.favoriteButton?.isHidden = !value
        favoriteButton.titleLabel?.textAlignment = .center
        self._favoriteType = favoriteType
        return self
    }
    
    func configurationScanImage() {
        let scanImage = UIImage(systemName: "barcode.viewfinder")
        self.scanButton.setImage(scanImage, for: .normal)
        self.scanButton.setTitle("Scan", for: .normal)
       //let scanImage = UIImage(systemName: "barcode.viewfinder")
       // let scanTab = UITabBarItem(title: "Scan", image: UIImage(named: "YOUR_IMAGE_NAME_FROM_ASSETS")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), tag: 1)
}
}
