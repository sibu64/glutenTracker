//
//  TextFieldFormView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 06/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

@IBDesignable
//Component for TextField
class TextFieldFormView: UIView, NibLoadable {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Label for TextField's component
    @IBOutlet private weak var titleLabel: UILabel!
    // TextField for TextField's component
    @IBOutlet private weak var nameTextField: UITextField!
    // Properties
    // CallBack for changed value
    private var didChange: ((String)->Void)?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    // initialization
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.commonInit()
    }
    // initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    // setting up the Nib
    private func commonInit() {
        setFromNib()
    }
    //Prepares the receiver for service after it has been loaded from the nib file.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // Configuration of the component (TextField and Label)
    public func configure(with title: String, placeholderTitle: String) {
        self.titleLabel?.text = title
        self.nameTextField?.placeholder = placeholderTitle
    }
    
    // setting up the nameTextField
    public func set(_ name: String?) {
        self.nameTextField?.text = name
    }
    // Expose change callback to public
    func didChange(_ completion: ((String)->Void)?) {
        self.didChange = completion
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    // Handling action changed
   @IBAction func actionChanged(_ sender: UITextField) {
       didChange?(sender.text!)
   }
}
