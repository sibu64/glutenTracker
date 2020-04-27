//
//  GetRecordLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 25/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

// Get test class 
class GetRecordLogic_Tests: XCTestCase {

    // Mock for get records in case of success
    func test_get_record_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = GetRecordLogic(service: mockService)
        
        let model = Product.fake
        logic.run(with: model, completion: nil)
        
        XCTAssertEqual(mockService.getCountCalled, 1)
        XCTAssertEqual(mockService.objectId, "10")
    }
    
    // Stub for get records in case of success
    func test_get_record_calls_success_with_data() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        stubService.record = Product.fake.toOffline
        let logic = GetRecordLogic(service: stubService)
        
        var model: Product?
        logic.run(with: Product.fake) { result in
            if case .success(let product) = result {
                model = product
            }
        }
        
        XCTAssertEqual(model, Product.fake)
    }
    
    // Stub for get records in case of failure with empty data
    func test_get_record_calls_failure_with_empty_data() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        let logic = GetRecordLogic(service: stubService)
        
        var error: Error?
        logic.run(with: Product.fake) { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
        XCTAssertEqual((error as NSError?)?.code, 400)
        XCTAssertEqual(error?.localizedDescription, "Data not found")
    }
    
    // Stub for get records in case of failure
    func test_get_record_calls_failure() {
        let stubService = StubCloudKitServiceFailure(database: nil)
        let logic = GetRecordLogic(service: stubService)
        
        var error: Error?
        logic.run(with: Product.fake) { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
         XCTAssertEqual(error?.localizedDescription, "error")
    }
}
