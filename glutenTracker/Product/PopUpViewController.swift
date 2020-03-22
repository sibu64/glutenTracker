//
//  PopUpViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 22/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var product: Product?
    
    @IBOutlet weak var glutenLabel: UILabel!
    @IBAction func dismissPopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
   func glutenLabelValue()->String {
    guard let value = ProductViewModel.init(model: product!).model.isGlutenFree else{
            return "Gluten free: This information is not available"
        }
        return "Gluten free: \(value == true ? "Yes" : "No")"
    }
}
