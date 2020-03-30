////
////  NetworkProductManager_Tests.swift
////  glutenTrackerTests
////
////  Created by Darrieumerlou on 27/03/2020.
////  Copyright © 2020 Darrieumerlou. All rights reserved.
////
import XCTest
@testable import glutenTracker

class NetworkProductManager_Tests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_manager_hasBeenCalled() {
        let mock = MockApiCall()
        let manager = NetworkProductManager(api: mock)

        manager.searchProduct(with: "123" , success: nil, failure: nil)

        XCTAssertEqual(mock.params, "123")
        XCTAssertEqual(mock.countCalled, 1)
    }

    func test_manager_calls_success() {
        let stub = StubApiCallSuccess()
        let manager = NetworkProductManager(api: stub)

        var model: Product? = nil
        manager.searchProduct(with: "123", success: { product in
            model = product
        }, failure: nil)

        XCTAssertEqual(model, Product.fake)
    }
    
    func test_manager_calls_failure() {
        let stub = StubApiCallFailure()
        let manager = NetworkProductManager(api: stub)
        
        var error: Error? = nil
        manager.searchProduct(with: "123", success: nil) { err in
            error = err
        }
        
        XCTAssertEqual(error?.localizedDescription, "error")
    }

    func test_manager_with_default_value() {
        let manager = NetworkProductManager.default
        let api = manager.api is APICall

        XCTAssertTrue(api)
    }

}
