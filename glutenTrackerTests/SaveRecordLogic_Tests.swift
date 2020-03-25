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

class CloudKitService_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_save_record_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = SaveRecordLogic(service: mockService)
        
        let model = Product.fake
        logic.run(with: model, completion: nil)
        
        XCTAssertEqual(mockService.saveCountCalled, 1)
        
        let product = Product(with: mockService.record!)
        XCTAssertEqual(product, model)
    }
    
    
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
}
