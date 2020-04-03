//
//  OnboardingViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

class OnboardingViewController: UIViewController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var nextButton: UIButton!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func loadView() {
        super.loadView()
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    
    private func checkIcloudAvailability() {
        CloudKitAvailability.checkIfAvailable(success: {
            self.dismiss(animated: true) {
                OnboardingLogic.default.finish()
            }
        }, failure: { error in
            self.showError(error.localizedDescription)
        })
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionNext(_ sender: UIButton) {
        self.checkIcloudAvailability()
    }
}

