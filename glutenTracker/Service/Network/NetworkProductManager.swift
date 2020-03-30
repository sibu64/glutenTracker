//
//  NetworkProductManager.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class NetworkProductManager {
    var api: NetworkRequestProtocol?
    var product: Product?
    var error: Error?
       
    init(api: NetworkRequestProtocol?){
        self.api = api
    }

    func searchProduct(with barCode: String, success: @escaping (Product?)->Void, failure: @escaping (Error)->Void) {
        api?.searchProduct(with: barCode, success: success , failure: failure )
    }
}
  
extension NetworkProductManager {
    public static var `default`: NetworkProductManager {
        return NetworkProductManager(api: APICall())
    }
}


