//
//  OnboardingViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 02/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

// Controller to show the onboarding screen
class OnboardingViewController: UIViewController {
    
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    //Button to go to the next screen
    @IBOutlet weak var nextButton: UIButton!
    // ***********************************************
    // MARK: - Properties
    // ***********************************************
    // Width of the cell
    let cellPercentWidth: CGFloat = 0.7
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    // Creates the view that the controller manages.
    override func loadView() {
        super.loadView()
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2
    }
    // Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
            super.viewDidLoad()

        }
    
    
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    // Verifies that iCloud is available
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
    // Defines what action to set up i(f iCloud is available or not)
    @IBAction func actionNext(_ sender: UIButton) {
        self.checkIcloudAvailability()
    }

    }
    

