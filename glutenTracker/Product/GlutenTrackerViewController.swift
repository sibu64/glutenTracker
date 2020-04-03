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
    
    private var productViewModel: ProductViewModel?
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
    
     func viewDidAppear() {
        super.viewDidAppear(false)
        removeFromFavorite()
    }
    
    public func deletedProduct(_ viewModel: ProductViewModel) {
        if viewModel.model == productViewModel?.model {
            self.setAddFavoriteFooterView()
        }
    }
    
    public func deletedAllProducts() {
        self.setAddFavoriteFooterView()
    }
    // ***********************************************
    // MARK: - Segue
    // ***********************************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == .segueToDetails {
            let controller = segue.destination as? DetailsViewController
            controller?.productViewModel = self.productViewModel!
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
    private func loadBarCode(with scannedCode: String) {
        let api = APICall()

        self.loader?.startAnimating()
        api.searchProduct(with: scannedCode, success: { [weak self] product in
            //dump(product)
            guard let self = self else { return }
            guard let model = product else { return }
            self.productViewModel = ProductViewModel(model: model)
            self.modelingImageAndLabels()
            self.footerButtonView?.showDetailButton(true)
            self.loader?.stopAnimating()
        }) { [weak self] error in
            print(error)
            self?.loader?.stopAnimating()
        }
    }
    
    private func modelingImageAndLabels(){
        guard let viewModel = productViewModel else { return }
        self.imageViewProduct?.af.setImage(withURL: (viewModel.model.imageUrl!))
        codeLabel?.text = "Barcode: " + viewModel.model.barCode!
        productLabel?.text = viewModel.name
        glutenLabel?.text = viewModel.glutenLabel
        glutenLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        wheatImage.isHidden = !viewModel.shouldDisplayWheatImage
        
        doesRecordExist(with: viewModel.model) { [weak self] success in
            switch success {
            case true:
                self?.setRemoveFavoriteFooterView()
            case false:
                self?.setAddFavoriteFooterView()
            }
        }
    }
    
    private func setRemoveFavoriteFooterView() {
        self.footerButtonView?.setFavoriteTitle(text: "Remove from favorites")
        self.footerButtonView?.showFavoriteButton(true, favoriteType: .remove)
    }
    
    private func setAddFavoriteFooterView() {
        self.footerButtonView?.setFavoriteTitle(text: "Add to favorites")
        self.footerButtonView?.showFavoriteButton(true, favoriteType: .add)
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
        guard let viewModel = self.productViewModel else {
            fatalError("Product doesn't exist")
        }
        SaveRecordLogic.default.run(with: viewModel.model) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.setRemoveFavoriteFooterView()
                    UIAlertWrapper.presentAlert(title: "Favorite", message: "Your favorite has been added!", cancelButtonTitle: "Ok")
                }
            }
        }
    }
    
    private func removeFromFavorite() {
        guard let viewModel = self.productViewModel else { return }

        doesRecordExist(with: viewModel.model, { success in
            switch success {
            case true:
                self.delete(viewModel.model)
            case false:
                self.setAddFavoriteFooterView()
            }
        })
    }
    
    private func delete(_ model: Product) {
        DeleteRecordLogic.default.run(model) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showError(error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.setAddFavoriteFooterView()
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
        if let _ = self.productViewModel {
            self.performSegue(withIdentifier: .segueToDetails, sender: nil)
        }
    }
    
    @IBAction func actionFavorite(sender: UIButton) {
        switch footerButtonView.favoriteType {
        case .add: saveToFavorite()
        case .remove: removeFromFavorite()
        }
    }
}
