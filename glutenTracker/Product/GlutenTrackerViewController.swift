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
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var glutenLabel: UILabel!
    @IBOutlet weak var wheatImage: UIImageView!
    @IBOutlet weak var widthWheatImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var footerButtonView: FooterButtonView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // Keep Product reference from API call
    private var model: Product?
    // ***********************************************
    // MARK: - Implementation
    // ***********************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        codeLabel?.text = "Scan to perform a research with a scan"
        productLabel?.text = "code on the product of your choice."
        glutenLabel?.text = "Check if it is gluten free!"
        
        footerButtonView?.showDetailButton(false)
    
        loadBarCode(with: "3274080001005") // No Gluten
        //loadBarCode(with: "3038359004544") // With Gluten
    }
    
     func viewDidAppear() {
        super.viewDidAppear(false)
        removeFromFavorite()
    }
    
    // Change button image when product has been deleted
    public func deletedProduct(_ model: Product) {
        if model == model {
            self.setFavoriteFooterView(with: .add)
        }
    }
    
    // Change button image when all products are deleted
    public func deletedAllProducts() {
        self.setFavoriteFooterView(with: .add)
    }
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .segueToDetails {
            let controller = segue.destination as? DetailsViewController
            controller?.model = self.model!
        } else if segue.identifier == .scannerSegue {
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
    // Fetch API with bar code from OpenFoodFacts
    private func loadBarCode(with scannedCode: String) {
        let api = APICall()

        self.loader?.startAnimating()
        api.searchProduct(with: scannedCode, success: { [weak self] product in
            //dump(product)
            guard let self = self else { return }
            self.model = product
            self.modelingImageAndLabels()
            self.footerButtonView?.showDetailButton(true)
            self.loader?.stopAnimating()
        }) { [weak self] error in
            print(error)
            self?.loader?.stopAnimating()
        }
    }
    
    // Manage UI when Product is loaded
    private func modelingImageAndLabels(){
        guard let model = model else { return }
        self.imageViewProduct?.af.setImage(withURL: (model.imageUrl!))
        codeLabel?.text = "Barcode: " + model.barCode!
        productLabel?.text = model.productName
        glutenLabel?.text = model.glutenLabel
        glutenLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        let value = !model.shouldDisplayWheatImage
        if value == true {
            wheatImage.isHidden = true
            widthWheatImageConstraint.constant = 0
        } else {
            wheatImage.isHidden = false
            widthWheatImageConstraint.constant = 70
        }
        
        doesRecordExist(with: model) { [weak self] success in
            switch success {
            case true:
                self?.setFavoriteFooterView(with: .remove)
            case false:
                self?.setFavoriteFooterView(with: .add)
            }
        }
    }
    
    // Update favorite button
    private func setFavoriteFooterView(with value: FooterButtonView.Favorite) {
        self.footerButtonView?.setFavoriteTitle(value: value)
        self.footerButtonView?.showFavoriteButton(true, favoriteType: value)
    }
   
    // Check if Product exists on CloudKit
    private func doesRecordExist(with model: Product, _ completion: ((Bool)->Void)?) {
        GetRecordLogic.default.run(with: model){ result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    completion?(false)
                }
            case .success(_):
                DispatchQueue.main.async {
                    completion?(true)
                }
            }
        }
    }
    
    // Save Product to CloudKit
    private func saveToFavorite() {
        guard let model = self.model else { return }
        SaveRecordLogic.default.run(with: model) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.setFavoriteFooterView(with: .remove)
                    UIAlertWrapper.presentAlert(title: "Favorite", message: "Your favorite has been added!", cancelButtonTitle: "Ok")
                }
            }
        }
    }
    
    // Remove Product from CloudKit
    private func removeFromFavorite() {
        guard let model = self.model else { return }

        doesRecordExist(with: model, { success in
            switch success {
            case true:
                self.delete(model)
            case false:
                self.setFavoriteFooterView(with: .add)
            }
        })
    }
    
    // Delete Product from CloudKit
    private func delete(_ model: Product) {
        DeleteRecordLogic.default.run(model) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.setFavoriteFooterView(with: .add)
                    UIAlertWrapper.presentAlert(title: "Deletion", message: "Your favorite has been deleted!", cancelButtonTitle: "Ok")
                }
            }
        }
    }
    
    private func presentAlertForCheckingExistingProduct() {
        UIAlertWrapper.presentAlert(title: "Oooops!", message: "You already have this product in your favorites", cancelButtonTitle: "Ok")
    }
    
    func presentAlertForNonExistingProduct() {
        UIAlertWrapper.presentAlert(title: "Sorry!", message: "The product was not found. Scan the bar code of the disired product", cancelButtonTitle: "Ok")
    }
    
    // ***********************************************
    // MARK: - Actions
    // ***********************************************
    // Open details product
    @IBAction func actionOpenDetails(sender: UIButton) {
        if let _ = self.model {
            self.performSegue(withIdentifier: .segueToDetails, sender: nil)
        }
    }
    
    // Action to add or remove product to favorite
    @IBAction func actionFavorite(sender: UIButton) {
        switch footerButtonView.favoriteType {
        case .add: saveToFavorite()
        case .remove: removeFromFavorite()
        }
    }
}
