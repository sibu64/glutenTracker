//
//  ProfileViewController.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 24/02/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: UITableViewController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet weak var firstnameFormView: TextFieldFormView?
    @IBOutlet weak var lastnameFormView: TextFieldFormView?
    @IBOutlet weak var emailFormView: TextFieldFormView?
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    // Properties
    private var model: Profile = Profile() {
        didSet {
            self.enableSaveButton()
        }
    }
    private let saveLogic = SaveProfileLogic.default
    private let getLogic = GetProfileLogic.default
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func loadView() {
        super.loadView()
        self.enableSaveButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        getProfile()
        
        // Firstname
        firstnameFormView?
            .configure(with: "Firstname", placeholderTitle: "Enter your firstname")
        firstnameFormView?.didChange({ value in
            self.model.firstname = value
            self.enableSaveButton()
        })
        
        // Lastname
        lastnameFormView?.configure(with: "Lastname", placeholderTitle: "Enter your lastname")
        lastnameFormView?.didChange({ value in
            self.model.lastname = value
            self.enableSaveButton()
        })
        
        // Email
        emailFormView?.configure(with: "Email", placeholderTitle: "Enter your email")
        emailFormView?.didChange({ value in
            self.model.email = value
            self.enableSaveButton()
        })
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    @IBAction func actionDismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.tableView.endEditing(true)
    }
    
    private func set(_ model: Profile) {
        firstnameFormView?.set(model.firstname)
        lastnameFormView?.set(model.lastname)
        emailFormView?.set(model.email)
    }
    
    private func enableSaveButton() {
        self.saveBarButtonItem.isEnabled = self.model.isValid
    }
    
    private func getProfile() {
        getLogic.run { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(_): return
                case .success(let profile):
                    self.model = profile
                    self.set(profile)
                }
            }
        }
    }
    
    private func saveProfile() {
        saveLogic.run(with: self.model) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let err):
                    self.showError(err.localizedDescription)
                case .success(_):
                    self.showAlert(
                        title: "Profile",
                        message: "Your profile has been saved !"
                    )
                }
            }
        }
    }
    // ***********************************************
    // MARK: - Action
    // ***********************************************
    @IBAction func actionSave(_ sender: UIBarButtonItem) {
        if self.model.isValid {
            self.saveProfile()
            self.saveBarButtonItem.isEnabled = false
        }
    }
}
