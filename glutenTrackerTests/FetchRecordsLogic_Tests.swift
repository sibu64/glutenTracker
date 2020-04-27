//
//  FetchRecordsLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 26/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

// Fetch test class 
class FetchRecordsLogic_Tests: XCTestCase {

    // Mock for fetch records in case of success
    func test_fetch_records_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = FetchRecordsLogic(service: mockService)
        
        logic.run(nil)
        
        XCTAssertEqual(mockService.fetchCountCalled, 1)
    }

    //Stub for fetch records in case of success
    func test_fetch_records_calls_success() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        let logic = FetchRecordsLogic(service: stubService)
        
        var model: Product? = nil
        logic.run { result in
            if case .success(let products) = result {
                model = products.first
            }
        }
        
        XCTAssertEqual(model, Product.fake)
    }
    // Stub for fetch records in case of failure
    func test_fetch_records_calls_failure() {
        let stubService = StubCloudKitServiceFailure(database: nil)
        let logic = FetchRecordsLogic(service: stubService)
    
        var error: Error? = nil
        logic.run { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
        XCTAssertEqual(error?.localizedDescription, "error")
    }
    
    // Test to verify default is used
    func test_default_is_mapped() {
        let logic = FetchRecordsLogic.default
        let service = (logic.service as Any) is CloudKitService
        
        XCTAssertEqual(service, true)
    }
}
