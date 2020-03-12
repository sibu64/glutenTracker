//
//  String_Tests.swift
//  glutenTrackerTests
//
//  Created by Darrieumerlou on 10/03/2020.
//  Copyright © 2020 Darrieumerlou. All rights reserved.
//

import XCTest

class String_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_clean_string_from_api() {
        let value = "simon 13%, simon 7.4%, simon 6,6%".cleanString
        
        XCTAssertEqual(value, "simon,simon,simon")
    }

    func test_clean_tag_from_api() {
        let value = "en:milk,en:nuts,en:soybeans".removeTags
        
        XCTAssertEqual(value, "milk,nuts,soybeans")
    }
    
    func test_string_with_comma_returns_an_array() {
        let value = "simon,simon,simon".joinedByComma
        
        XCTAssertEqual(value?.first, "simon")
        XCTAssertEqual(value?.last, "simon")
        XCTAssertEqual(value?.count, 3)
    }
}
