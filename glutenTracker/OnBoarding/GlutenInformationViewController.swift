//
//  GlutenInformationViewController.swift
//  
//
//  Created by Darrieumerlou on 08/04/2020.
//

import UIKit

// Controller to display gluten's warnings
class GlutenInformationViewController: UIViewController {
    //Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Handling action dismiss
    @IBAction func actionDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
