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
    // todo: remove ? for the outlets
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var glutenLabel: UILabel!
    @IBOutlet weak var wheatImage: UIImageView!
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
        
        codeLabel?.text = "Scan to perform a research with a scan"
        productLabel?.text = "code on the product of your choice."
        glutenLabel?.text = "Check if it is gluten free!"
        
        
        footerButtonView?.showDetailButton(false)
    
        //loadBarCode(with: "3274080001005") // No Gluten
       loadBarCode(with: "3038359004544") // With Gluten
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
            //dump(product)
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
        glutenLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        wheatImage.isHidden = !viewModel.shouldDisplayWheatImage
        
        doesRecordExist(with: model) { [weak self] success in
            switch success {
            case true:
                self?.footerButtonView?.setFavoriteTitle(text: "Remove from favorites")
                self?.footerButtonView?.showFavoriteButton(true, favoriteType: .remove)
            case false:
                
                self?.footerButtonView?.setFavoriteTitle(text: "Add to favorites")
                self?.footerButtonView?.showFavoriteButton(true, favoriteType: .add)
            }
        }
    }
    
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
    
    private func saveToFavorite() {
        guard let value = self.product else {
            fatalError("Product doesn't exist")
        }
        SaveRecordLogic.default.run(with: value) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.footerButtonView.setFavoriteTitle(text: "Remove from favorites")
                    self?.footerButtonView.showFavoriteButton(true, favoriteType: .remove)
                    UIAlertWrapper.presentAlert(title: "Favorite", message: "Your favorite has been added!", cancelButtonTitle: "Ok")
                }
            }
        }
    }
    
    private func removeFromFavorite() {
        guard let value = self.product else {
            fatalError("Product doesn't exist")
            
        }
        DeleteRecordLogic.default.run(value) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.footerButtonView.setFavoriteTitle(text: "Add to favorites")
                    self?.footerButtonView.showFavoriteButton(true, favoriteType: .add)
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
    @IBAction func actionOpenDetails(sender: UIButton) {
        if let _ = self.product {
            self.performSegue(withIdentifier: Segue.segueToDetails, sender: nil)
        }
    }
    
    @IBAction func actionFavorite(sender: UIButton) {
        switch footerButtonView.favoriteType {
        case .add: saveToFavorite()
        case .remove: removeFromFavorite()
        }
    }
}
