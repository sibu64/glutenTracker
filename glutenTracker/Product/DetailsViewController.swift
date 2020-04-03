//
//  DetailsViewController.swift
//

import UIKit

class DetailsViewController: UIViewController {

    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // Public
    var productViewModel: ProductViewModel!
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

        codeLabel?.text = productViewModel.model.barCode
        productNameLabel?.text = productViewModel.name

        let ingredientsProduct = productViewModel.model.ingredients ?? []
        for ingredient in ingredientsProduct {
            print("\(ingredient)")
        }
        self.listView?.setUp(ingredients: ingredientsProduct)
        
        self.allergensProductNameLabel?.text = productViewModel.allergensText
        self.allergensProductNameLabel?.font = UIFont.boldSystemFont(ofSize: 21.0)
    }
    
}
