//
//  DeleteRecordLogic_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 25/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import glutenTracker

class DeleteRecordLogic_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
    
    #warning("Test this")
    func test_default_is_mapped() {
        let logic = DeleteRecordLogic.default
        let service = logic.service === CloudKitService()
        
        XCTAssertEqual(service, true)
    }
}
