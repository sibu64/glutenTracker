//
//  CloudKitService_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 12/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
import CloudKit
@testable import glutenTracker

// Save test class 
class SaveRecordLogic_Tests: XCTestCase {

    // Mock for save records in case of success
    func test_save_record_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = SaveRecordLogic(service: mockService)
        
        let model = Product.fake
        logic.run(with: model, completion: nil)
        
        XCTAssertEqual(mockService.saveCountCalled, 1)
        
        let product = Product(with: mockService.record!)
        XCTAssertEqual(product, model)
    }
    
    // Stub for save records in case of success
    func test_save_record_calls_success() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        let logic = SaveRecordLogic(service: stubService)
        
        var successCalled: Bool = false
        logic.run(with: Product.fake) { result in
            if case .success() = result {
                successCalled = true
            }
        }
        
        XCTAssertEqual(successCalled, true)
    }
    
    // Stub for save records in case of failure
    func test_save_record_calls_failure() {
        let stubService = StubCloudKitServiceFailure(database: nil)
        let logic = SaveRecordLogic(service: stubService)
        
        var error: Error? = nil
        logic.run(with: Product.fake) { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
        XCTAssertEqual(error?.localizedDescription, "error")
    }
    
    // Test to verify default is used
    func test_default_is_mapped() {
        let logic = SaveRecordLogic.default
        let service = (logic.service as Any) is CloudKitService
        
        XCTAssertEqual(service, true)
    }
}
