//
//  FoodTrackerViewController.swift
//
//

import UIKit
import AlamofireImage
import Alamofire
import CloudKit

class GlutenTrackerViewController: UIViewController {
    // ***********************************************
    // MARK: - Interface
    // ***********************************************
    // IBOutlet
    // todo: remove ? for the outlets
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var removeFavoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var glutenLabel: UILabel!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var footerButtonView: FooterButtonView!

    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    //todo: remove Product (ProductViewModel instead)
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
        
        loadBarCode(with: "3166350001450")
        removeFavoriteBarButtonItem.isEnabled = false
        removeFavoriteBarButtonItem.tintColor = UIColor.clear
        removeFavoriteBarButtonItem.isAccessibilityElement = false
    }
    
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.segueToDetails {
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
        let api = APICall()
        self.loader?.startAnimating()
        api.searchProduct(with: scannedCode, success: { [weak self] product in
            dump(product)
            guard let self = self else { return }
            self.product = product
            self.modelingImageAndLabels()
            self.footerButtonView?.showDetailButton(true)
            self.loader?.stopAnimating()
        }) { [weak self] error in
            print(error)
            self?.loader?.stopAnimating()
        }
    }
    
    private func modelingImageAndLabels(){
        guard let model = product else { return }
        let viewModel = ProductViewModel(model: model)
        self.imageViewProduct?.af.setImage(withURL: (model.imageUrl!))
        codeLabel?.text = model.barCode
        productLabel?.text = viewModel.name
        glutenLabel?.text = viewModel.glutenLabel
        glutenLabel?.font = UIFont.boldSystemFont(ofSize: 21.0)
    }
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    @IBAction func actionOpenDetails(sender: UIButton) {
        if let _ = self.product {
            self.performSegue(withIdentifier: Segue.segueToDetails, sender: nil)
        }
    }
    
    @IBAction func actionFavorite(_ sender: UIBarButtonItem) {
        guard let value = self.product else { return }
        SaveRecordLogic.default.run(with: value) { result in
            switch result {
            case .success(_):
                self.removeFavoriteBarButtonItem.isEnabled = true
                self.removeFavoriteBarButtonItem.tintColor = UIColor.systemYellow
                self.favoriteBarButtonItem.isEnabled = false
                self.favoriteBarButtonItem.isAccessibilityElement = false
                self.favoriteBarButtonItem.tintColor = UIColor.clear
                print("Success")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    @IBAction func removeToFavorites(_ sender: UIBarButtonItem) {
        delete(removeFavoriteBarButtonItem)
        
    }
    
    
}
