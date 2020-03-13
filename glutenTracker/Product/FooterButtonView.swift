//
//  FooterButtonView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 04/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class FooterButtonView: UIStackView {
    @IBOutlet weak var scanButton : UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    func showDetailButton(_ value: Bool) {
        detailButton?.isHidden = !value
    }
}
