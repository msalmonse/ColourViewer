//
//  ColoursMatching.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-21.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
import SwiftUI
@testable import ColourViewer

class ColoursMatchingTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testColoursMatching() {
        XCTAssertEqual(coloursMatching("gre").count, 21)
        XCTAssertEqual(coloursMatching("grex").count, 0)
        XCTAssertEqual(coloursMatching("white", sortByIntensity: true)[0], "White")
    }

    func testHexLookup() {
        XCTAssertEqual(hexLookup("green"), "#00ff00")
        XCTAssertEqual(hexLookup("BLUE"), "#0000ff")
        XCTAssertNil(hexLookup("poop"))
    }
    
    func testColorLookup() {
        XCTAssertEqual(colorLookup("Blue"), Color(red: 0, green: 0, blue: 255))
        XCTAssertNil(colorLookup("Poop"), "Poop is not a colour")
    }
}
