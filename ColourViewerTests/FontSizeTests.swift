//
//  FontSize.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-08-02.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
@testable import ColourViewer

class FontSize: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testlargerFont() {
        XCTAssertEqual(largerFont(.body), .subheadline)
        XCTAssertEqual(largerFont(.callout, by: 2), .subheadline)
        XCTAssertEqual(largerFont(.body, by: 0), .body)
        XCTAssertEqual(largerFont(.body, by: 10), .largeTitle)
    }

    func testSmallerFont() {
        XCTAssertEqual(smallerFont(.body), .callout)
        XCTAssertEqual(smallerFont(.title, by: 2), .subheadline)
        XCTAssertEqual(smallerFont(.body, by: 0), .body)
        XCTAssertEqual(smallerFont(.body, by: 10), .footnote)
    }

}
