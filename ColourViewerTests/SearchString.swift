//
//  SearchString.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
@testable import ColourViewer

class SearchStringTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchString() {
        var testRes = "Z"
        var test = SearchString()
        let testCancel = test.publisher.sink(receiveValue: { testRes = $0 })
        
        test.string = "A"
        XCTAssertEqual(testRes, "Z", "less than min")
        test.string = "AA"
        XCTAssertEqual(testRes, "AA", "equal to min")
        testCancel.cancel()
        test.string = "ZZZ"
        XCTAssertEqual(testRes, "AA", "sink cancelled")
    }

}
