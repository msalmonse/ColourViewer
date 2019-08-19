//
//  NumberAndString.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
import SwiftUI
@testable import ColourViewer

class NumberAndStringTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIntAndString() {
        let test = IntAndString(number: 100, min: 1, max: 255, radix: .decimal)
        var testVal = 0

        XCTAssertEqual(test.string, "100")
        test.number = 99
        XCTAssertEqual(test.string, "99")
        test.number = 0
        XCTAssertEqual(test.number, 99, "number < min")
        test.number = 256
        XCTAssertEqual(test.number, 99, "number > max")
        test.number = 128
        test.setRadix(radix: .hexadecimal)
        XCTAssertEqual(test.string, "80")
        test.string = "aa"
        XCTAssertEqual(test.number, 170)
        test.string = "ax"
        XCTAssertEqual(test.number, 170, "illegal hex string")
        test.string = "100"
        XCTAssertEqual(test.number, 170, "number too big")
        test.string = "0"
        XCTAssertEqual(test.number, 170, "number too small")

        test.hasChanged = { testVal = $0 }
        test.number = 100
        XCTAssertEqual(testVal, 100)
    }

    func testDoubleAndString() {
        let test = DoubleAndString(number: 10.0, min: 1.0, max: 100.0)
        var testVal = 0.0

        XCTAssertEqual(test.string, "10.00")
        test.number = 99
        XCTAssertEqual(test.string, "99.00")
        test.number = 0.0
        XCTAssertEqual(test.number, 99.0, "number < min")
        test.number = 101.0
        XCTAssertEqual(test.number, 99.0, "number > max")
        test.string = "100.01"
        XCTAssertEqual(test.number, 99.0, "number too big")
        test.string = "0"
        XCTAssertEqual(test.number, 99.0, "number too small")

        test.hasChanged = { testVal = $0 }
        test.number = 50.0
        XCTAssertEqual(testVal, 50.0)

        test.wrapMax = 100.0
        test.number = 1234.0
        XCTAssertEqual(test.number, 46.0, "After wrapping")
        test.number = -1.0
        XCTAssertEqual(test.number, 98.0, "After wrapping negative")
        test.string = "4321.0"
        XCTAssertEqual(test.number, 64.0, "After wrapping string")
    }
}
