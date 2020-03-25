//
//  GetRecordLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 25/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

class GetRecordLogic_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_get_record_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = GetRecordLogic(service: mockService)
        
        let model = Product.fake
        logic.run(with: model, completion: nil)
        
        XCTAssertEqual(mockService.getCountCalled, 1)
        XCTAssertEqual(mockService.objectId, "10")
    }
    
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
