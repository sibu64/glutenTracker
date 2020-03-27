//
//  APICallFake.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 27/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

//import Foundation
//@testable import glutenTracker
//
//public class MockApiCall: NetworkRequestProtocol {
//   
//    init()
//    
//    private(set) var failure: (Error) -> Void
//    private(set) var success: (Product?) -> Void
//    private(set) var countCalled: NSInteger = 0
//    private(set) var params: String?
//    
//    func searchProduct(with barCode: String?, success: @escaping (Product?) -> Void, failure: @escaping (Error) -> Void) {
//         self.countCalled += 1
//         self.params = barCode
//         self.success = success
//         self.failure = failure
//        
//    }
//    
//}
//
//class StubApiCall: NetworkRequestProtocol {
//   
//    func searchProduct(with barCode: String?, success: @escaping (Product?) -> Void, failure: @escaping (Error) -> Void) {
//        let data = Data.from("search")
//        
//        do {
//            let welcome = try Welcome(data: data)
//            //let object = try JSONDecoder().decode(Welcome.self, from: data)
//            let recipes = welcome.hits.map { $0.recipe }
//            completion?(recipes)
//        } catch let error {
//            print("Error: \(error)")
//        }
//        
//    }
//}
//
