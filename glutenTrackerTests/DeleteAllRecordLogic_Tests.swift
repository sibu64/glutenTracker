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

    func test_delete_all_records_haveBeenCalled() {
        let mockService = MockCloudKitService(database: nil)
        let logic = DeleteAllLogic(service: mockService)
        
        logic.run(completion: nil)
        
        XCTAssertEqual(mockService.deleteAllCountCalled, 1)
    }

    func test_delete_all_records_call_success() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        let logic = DeleteAllLogic(service: stubService)
        
        var successCalled: Bool = false
        logic.run { result in
            if case .success(_) = result {
                successCalled = true
            }
        }
        
        XCTAssertEqual(successCalled, true)
    }
    
    func test_delete_all_records_call_failure() {
        let stubService = StubCloudKitServiceFailure(database: nil)
        let logic = DeleteAllLogic(service: stubService)
        
        var error: Error? = nil
        logic.run { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
        XCTAssertEqual(error?.localizedDescription, "error")
    }
    
    func test_default_is_mapped() {
        let logic = DeleteAllLogic.default
        let service = (logic.service as Any) is CloudKitService
        
        XCTAssertEqual(service, true)
    }
}

