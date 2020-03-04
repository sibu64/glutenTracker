//
//  detailsViewController.swift
//

import UIKit

class DetailsViewController: UIViewController {

    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Public
    var product: Product?
    // IBOutlet
    @IBOutlet weak var codeLabel: UILabel?
    @IBOutlet weak var productNameLabel: UILabel?
    @IBOutlet weak var allergensProductNameLabel: UILabel?
    @IBOutlet weak var backButton: UIButton?
    @IBOutlet weak var listView: IngredientListView?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton?.layer.cornerRadius = 25

        codeLabel?.text = product?.barCode
        productNameLabel?.text = product?.name

        let ingredientsProduct = product?.ingredients ?? []
        for ingredient in ingredientsProduct {
            print("\(ingredient)")
        }
        self.listView?.setUp(ingredients: ingredientsProduct)
        
        let allergenValue = product?.allergens?.isEmpty == true ? "Pas d'allergéne" : "Allergénes: \(product!.allergens!)"
        self.allergensProductNameLabel?.text = allergenValue
    }
    
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
}