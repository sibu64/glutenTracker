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
        let logic = SaveRecord(service: mockService)
        
        let model = Product.fake
        logic.run(with: model, completion: nil)
        
        XCTAssertEqual(mockService.saveCountCalled, 1)
        
        let product = Product(with: mockService.record!)
        XCTAssertEqual(product, model)
    }
    
    
    func test_save_record_calls_success() {
        let stubService = StubCloudKitServiceSuccess(database: nil)
        let logic = SaveRecord(service: stubService)
        
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
        let logic = SaveRecord(service: stubService)
        
        var error: Error? = nil
        logic.run(with: Product.fake) { result in
            if case .failure(let err) = result {
                error = err
            }
        }
        
        XCTAssertEqual(error?.localizedDescription, "error")
    }
}

class StubCloudKitServiceFailure: CloudKitService {
    override func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) -> Void)) {
        completion(nil, NSError.fake)
    }
}

class StubCloudKitServiceSuccess: CloudKitService {
    override func save(_ record: CKRecord, completion: @escaping ((CKRecord?, Error?) -> Void)) {
        completion(Product.fake.toOffline, nil)
    }
}

class MockCloudKitService: CloudKitService {
    private(set) var saveCountCalled = 0
    private(set) var record: CKRecord? = nil
    
    override func save(_ record:    CKRecord, completion: @escaping ((CKRecord?, Error?) -> Void)) {
        self.saveCountCalled += 1
        self.record = record
    }
}

