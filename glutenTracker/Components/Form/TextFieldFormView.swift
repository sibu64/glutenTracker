//
//  TextFieldFormView.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 06/04/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldFormView: UIView, NibLoadable {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    // Properties
    private var didChange: ((String)->Void)?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        setFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with title: String, placeholderTitle: String) {
        self.titleLabel?.text = title
        self.nameTextField?.placeholder = placeholderTitle
    }
    
    public func set(_ name: String?) {
        self.nameTextField?.text = name
    }
    
    func didChange(_ completion: ((String)->Void)?) {
        self.didChange = completion
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
   @IBAction func actionChanged(_ sender: UITextField) {
       didChange?(sender.text!)
   }
}
