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
    var productViewModel: ProductViewModel?
    
    
    
    @IBAction func dimissPopUpButton(_ sender: Any) {
    }
    @IBOutlet weak var wheatImage: UIImageView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var glutenLabel: UILabel!
    
    @IBAction func dismissPopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    init(glutenLabel: UILabel) {
        super.init(nibName: nil, bundle: nil)
        self.glutenLabel = glutenLabel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
