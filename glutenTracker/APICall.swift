//
//  API.swift
//  GlutenTracker
//
//  Created by Darrieumerlou on 11/05/2018.
//  Copyright © 2018 Darrieumerlou. All rights reserved.
//

import Foundation
import Alamofire

class APICall {
    
    private var baseUrl: String = "https://world.openfoodfacts.org/api/v0/products/"
    
    func searchProduct(with barCode: String, success: @escaping (Product?)->Void, failure: @escaping (Error)->Void) {
        let urlStringProduct: String = baseUrl + barCode + ".json"
        guard let url = URL(string: urlStringProduct)
            else {return}
        AF.request(url).responseJSON
        {
        (response) in
            if response.error == nil {
                
                if let response = response.value as? [String: AnyObject] {
                    let status_verbose = response["status_verbose"] as? String
                    if status_verbose == "product not found" {
                        success(nil)
                        return
                    } else {
                        if let product = response["product"] as? [String: AnyObject] {
                            let prod = Product(json: product)
                            success(prod)
                        }
                    }
                }
            }else{
                failure(response.error!)
            }
        }
    }
}
