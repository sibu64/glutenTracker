//
//  FetchRecordsLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 26/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

class FetchRecordsLogic_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fetch_records_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = FetchRecordsLogic(service: mockService)
        
        logic.run(nil)
        
        XCTAssertEqual(mockService.fetchCountCalled, 1)
    }

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
    
    func test_default_is_mapped() {
        let logic = FetchRecordsLogic.default
        let service = (logic.service as Any) is CloudKitService
        
        XCTAssertEqual(service, true)
    }
}
