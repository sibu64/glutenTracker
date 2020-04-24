//
//  helpViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 13/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

// Class managing the help screen
class HelpViewController: UIViewController {

// Images for gluten and gluten-free
    @IBOutlet weak var glutenFreeImageView: UIImageView!
    @IBOutlet weak var glutenImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayImages()
    }
    
// Function displaying the images
    func displayImages(){
    glutenFreeImageView.image = UIImage(named: "gluten-free")
    glutenImageView.image = UIImage(named: "gluten")
    }
    
}
