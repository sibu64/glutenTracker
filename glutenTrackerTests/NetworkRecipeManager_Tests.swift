////
////  NetworkRecipeManager_Tests.swift
////  glutenTrackerTests
////
////  Created by Darrieumerlou on 27/03/2020.
////  Copyright © 2020 Darrieumerlou. All rights reserved.
////
//
//import XCTest
//
//import XCTest
//@testable import glutenTracker
//
//class NetworkProductManager_Tests: XCTestCase {
//
//
//    func test_manager_hasBeenCalled() {
//        let mock = MockApiCall()
//        let manager = NetworkProductManager(api: mock)
//
//        manager.searchProduct(with: "123" , success: true, failure: nil)
//
//        XCTAssertEqual(mock.params?.first, "lemon")
//        XCTAssertEqual(mock.countCalled, 1)
//    }
//
//    func test_manager_calls_success() {
//        let stub = StubApiCall()
//        let manager = NetworkProductManager(api: stub)
//
//        var failure: ((Error)->Void)? = nil
//        var success: ((Product?)->Void)? = nil
//        var product: [Product]? = nil
//       // manager.get(ingredients: ["lemon"]) { recipes in
//        //manager.searchProduct(with: 123 , success: true, failure: nil) { product in
//        manager.searchProduct(with: "123", success: success) { product in
//            product = product.first
//        }
//
//        XCTAssertEqual(product, [Product.fake])
//    }
//
//    func test_manager_with_default_value() {
//        let manager = NetworkProductManager.default
//
//        let api = manager.api is APICall
//
//        XCTAssertTrue(api)
//    }
//
//}
