//
//  RGBandHSBtest.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
@testable import ColourViewer

class RGBandHSBtest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRGB() {
        let rgb = RGBandHSB(red: 51, green: 153, blue: 255)
        
        XCTAssertEqual(rgb.red.number, 51)
        rgb.red.number = 102
        XCTAssertEqual(rgb.red.number, 102)
        XCTAssertEqual(rgb.green.number, 153)
        XCTAssertEqual(rgb.blue.number, 255)
        
        rgb.setRadix(radix: .hexadecimal)
        XCTAssertEqual(rgb.red.string, "66")
        XCTAssertEqual(rgb.green.string, "99")
        XCTAssertEqual(rgb.blue.string, "ff")
    }

    func testHSB() {
        let rgb = RGBandHSB(red: 255, green: 255, blue: 255)
        
        XCTAssertEqual(rgb.brightness.number, 100.0)
        rgb.red.number = 0
        XCTAssertEqual(rgb.hue.number, 180.0)
        rgb.blue.number = 0
        XCTAssertEqual(rgb.hue.number, 120.0)
        XCTAssertEqual(rgb.saturation.number, 100.0)
        XCTAssertEqual(rgb.label, "Green")
        rgb.hue.number = 60.0
        XCTAssertEqual(rgb.label, "Yellow")
    }

}
