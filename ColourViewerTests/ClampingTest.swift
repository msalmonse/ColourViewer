//
//  ClampingTest.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
@testable import ColourViewer

class ClampingTest: XCTestCase {
    @Clamping(997...1003) var testValue: Int
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClamping() {
        testValue = 1004
        XCTAssert(testValue == 1003)
        testValue = 996
        XCTAssert(testValue == 997)
        testValue = 1000
        XCTAssert(testValue == 1000)
    }
}
