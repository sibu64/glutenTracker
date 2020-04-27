//
//  DeleteRecordLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 25/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

// Delete test class 
class DeleteRecordLogic_Tests: XCTestCase {

    // Mock for delete records in case of success
    func test_delete_record_calls_success() {
        let mockService = FakeDeleteRecordSuccessService(database: nil)
        let logic = DeleteRecordLogic(service: mockService)
        
        var successCalled: Bool = false
        logic.run(Product.fake) { result in
            if case .success(_) = result {
                successCalled = true
            }
        }
        
        XCTAssertEqual(successCalled, true)
    }
    // Mock for delete records in case of failure
    func test_delete_record_calls_failure() {
        let mockService = FakeDeleteRecordFailureService(database: nil)
        let logic = DeleteRecordLogic(service: mockService)
        
        var error: Error? = nil
        logic.run(Product.fake) { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
        XCTAssertEqual(error?.localizedDescription, "error")
    }
     // Test to verify default is used
     func test_default_is_mapped() {
           let logic = DeleteRecordLogic.default
           let service = (logic.service as Any) is CloudKitService
           
           XCTAssertEqual(service, true)
       }
}
