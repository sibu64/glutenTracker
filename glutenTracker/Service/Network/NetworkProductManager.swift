//
//  NetworkProductManager.swift
//  glutenTracker
//
//  Created by Darrieumerlou on 27/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation

class NetworkProductManager {
    private(set) var api: NetworkRequestProtocol?
       
    init(api: NetworkRequestProtocol? = nil){
        self.api = api
    }

    func searchProduct(with barCode: String, success: ((Product?)->Void)?, failure: ((Error)->Void)?) {
        api?.searchProduct(with: barCode, success: success , failure: failure )
    }
}
  
extension NetworkProductManager {
    public static var `default`: NetworkProductManager {
        return NetworkProductManager(api: APICall())
    }
}


