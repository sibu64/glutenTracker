//
//  FoodTrackerViewController.swift
//
//

import UIKit
import AlamofireImage
import Alamofire

class GlutenTrackerViewController: UIViewController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // IBOutlet
    @IBOutlet weak var codeLabel: UILabel?
    @IBOutlet weak var productLabel: UILabel?
    @IBOutlet weak var glutenLabel: UILabel?
    @IBOutlet weak var scanButton: UIButton?
    @IBOutlet weak var detailsButton: UIButton?
    @IBOutlet weak var imageViewProduct: UIImageView?
    @IBOutlet weak var footerButtonView: FooterButtonView?

    @IBOutlet weak var loader: UIActivityIndicatorView?
    // Public
    //variables de classes utilisables dans toute les fonctions
    //de la classe, précédées de "self"
    private var product: Product?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()

        scanButton?.layer.cornerRadius = 25
        detailsButton?.layer.cornerRadius = 25
        
        codeLabel?.text = "Scan to perform a research with a scan"
        productLabel?.text = "code on the product of your choice."
        glutenLabel?.text = "Check if it is gluten free"
        
        footerButtonView?.showDetailButton(false)
    }
    
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetails" {
            let controller = segue.destination as? DetailsViewController
            controller?.product = self.product
        } else if segue.identifier == Segue.scannerSegue {
            let navigation = segue.destination as? UINavigationController
            let controller = navigation?.children.first as? ScannerViewController
            controller?.didDecodeBarcode({ scannedCode in
                self.codeLabel?.text = scannedCode
                self.loadBarCode(with: scannedCode)
            })
        }
    }
    // ***********************************************
    // MARK: - Private Methods
    // ***********************************************
    private func loadBarCode(with scannedCode: String) {
        let api = API()
        self.loader?.startAnimating()
        api.searchProduct(with: scannedCode, success: { (product) in
            dump(product)
            self.product = product
            let viewModel = ProductViewModel(model: product!)
            self.codeLabel?.text = viewModel.model.barCode
            self.productLabel?.text = viewModel.name
            self.glutenLabel?.text = viewModel.glutenLabel
            self.imageViewProduct?.af.setImage(withURL: (viewModel.model.imageUrl)!)
            self.footerButtonView?.showDetailButton(true)
            self.loader?.stopAnimating()
        }) { (error) in
            print(error)
            self.loader?.stopAnimating()
        }
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionOpenDetails(sender: UIButton) {
        if let _ = self.product {
            self.performSegue(withIdentifier: "segueToDetails", sender: nil)
        }
    }
    
} // class OpenFoodViewController: UIViewController
