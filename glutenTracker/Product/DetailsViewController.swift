//
//  DetailsViewController.swift
//

import UIKit

class DetailsViewController: UIViewController {

    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Public
    // Product from GlutenTrackerViewController
    var model: Product!
    // IBOutlet
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var allergensProductNameLabel: UILabel!
    @IBOutlet weak var listView: IngredientListView!
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.systemYellow

        codeLabel?.text = model.barCode
        productNameLabel?.text = model.productName

        let ingredientsProduct = model.ingredients ?? []
        for ingredient in ingredientsProduct {
            print("\(ingredient)")
        }
        self.listView?.setUp(ingredients: ingredientsProduct)
        
        self.allergensProductNameLabel?.text = model.allergensText
        self.allergensProductNameLabel?.font = UIFont.boldSystemFont(ofSize: 21.0)
    }
    
}
