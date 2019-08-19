//
//  ColourItem.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-22.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
@testable import ColourViewer

class ColourItemTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHexRGB() {
        XCTAssertEqual(ColourItem(hex: "#3399ff"), ColourItem(red: 51, green: 153, blue: 255))
        XCTAssertEqual(ColourItem(hex: "#3399ff"), ColourItem(hex: "#39f"))
        XCTAssertNil(ColourItem(hex: "#39ff"), "wrong count")
        XCTAssertNil(ColourItem(hex: "#39g"), "wrong digit")
        XCTAssertNil(ColourItem(hex: "39ff"), "wrong prefix")
    }

}
