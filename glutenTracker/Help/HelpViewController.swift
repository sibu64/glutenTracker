//
//  helpViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 13/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    @IBOutlet weak var glutenFreeImageView: UIImageView!
    @IBOutlet weak var glutenImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayImages()
    }
    
    
    func displayImages(){
    glutenFreeImageView.image = UIImage(named: "gluten-free")
    glutenImageView.image = UIImage(named: "gluten")
    }
    
}
