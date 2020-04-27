//
//  DeleteAllRecordLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 26/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

// Delete all test class 
class DeleteAllRecordLogic_Tests: XCTestCase {

    // Mock for delete records in case of success
    func test_delete_all_records_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = DeleteRecordLogic(service: mockService)
        
        logic.runDeleteAll(completion: nil)
        
        XCTAssertEqual(mockService.deleteAllCountCalled, 1)
    }

    // Stub for delete records in case of success
    func test_delete_all_records_calls_success() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        let logic = DeleteRecordLogic(service: stubService)
        
        var successCalled: Bool = false
        logic.runDeleteAll { result in
            if case .success(_) = result {
                successCalled = true
            }
        }
        
        XCTAssertEqual(successCalled, true)
    }
    
    // Stub for delete records in case of failure
    func test_delete_all_records_calls_failure() {
        let stubService = StubCloudKitServiceFailure(database: nil)
        let logic = DeleteRecordLogic(service: stubService)
        
        var error: Error? = nil
        logic.runDeleteAll { result in
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

