//
//  DeleteAllRecordLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 26/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

class DeleteAllRecordLogic_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_delete_all_records_hasBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = DeleteRecordLogic(service: mockService)
        
        logic.runDeleteAll(completion: nil)
        
        XCTAssertEqual(mockService.deleteAllCountCalled, 1)
    }

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
    
    func test_default_is_mapped() {
        let logic = DeleteRecordLogic.default
        let service = (logic.service as Any) is CloudKitService
        
        XCTAssertEqual(service, true)
    }
}

