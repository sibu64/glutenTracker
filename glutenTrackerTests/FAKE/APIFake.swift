//
//  APICallFake.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 27/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import Foundation
@testable import glutenTracker

// Mock for API
class MockApiCall: NetworkRequestProtocol {
    private(set) var countCalled: NSInteger = 0
       private(set) var params: String?
    
    func searchProduct(with barCode: String, success: ((Product?) -> Void)?, failure: ((Error) -> Void)?) {
        self.countCalled += 1
        self.params = barCode
    }
}

// Stub for API in case of sucess
class StubApiCallSuccess: NetworkRequestProtocol {
    func searchProduct(with barCode: String, success: ((Product?) -> Void)?, failure: ((Error) -> Void)?) {
                
        let data = Data.from("products")
        let json = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        let jsonProduct = json["product"] as! [String: Any]
        let model = Product(json: jsonProduct)
        success?(model)
    }
}

// Stub for API in case of a failure
class StubApiCallFailure: NetworkRequestProtocol {
    func searchProduct(with barCode: String, success: ((Product?) -> Void)?, failure: ((Error) -> Void)?) {
        failure?(NSError.fake)
    }
}
