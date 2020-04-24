//
//  API.swift
//  GlutenTracker
//
//  Created by Darrieumerlou on 11/05/2018.
//  Copyright © 2018 Darrieumerlou. All rights reserved.
//

import Foundation
import Alamofire

// Class to make the APICall. Implements the NetworkRequestProtocol.
class APICall: NetworkRequestProtocol {
    private var baseUrl: String = "https://fr.openfoodfacts.org/api/v0/produit/"
    
    func searchProduct(with barCode: String, success: ((Product?) -> Void)?, failure: ((Error) -> Void)?) {
        let urlStringProduct: String = baseUrl + barCode + ".json"
        guard let url = URL(string: urlStringProduct)
            else { return }
        AF.request(url).responseJSON
        {
        (response) in
            if response.error == nil {
                
                if let response = response.value as? [String: AnyObject] {
                    let status_verbose = response["status_verbose"] as? String
                    if status_verbose == "product not found" {
                        success?(nil)
                        return
                    } else {
                        if let product = response["product"] as? [String: AnyObject] {
                            let prod = Product(json: product)
                            success?(prod)
                        }
                    }
                }
            }else{
                failure?(response.error!)
            }
        }
    }
}
