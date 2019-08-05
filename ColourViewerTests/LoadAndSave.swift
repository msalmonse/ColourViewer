//
//  LoadAndSave.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-08-05.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest
@testable import ColourViewer

class LoadAndSaveTest: XCTestCase {
    static let test: [ColourItem] = [
        .init(red: 255, green: 0, blue: 0),
        .init(red: 0, green: 255, blue: 0),
        .init(red: 0, green: 0, blue: 255)
    ]
    static let filename = "testSave.json"

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSave() {
        XCTAssertTrue(saveAsJSON(Self.test, Self.filename))
    }
    
    func testLoad() {
        let loaded: [ColourItem]? = loadFromJSON(Self.filename)
        
        XCTAssertNotNil(loaded)
        XCTAssertEqual(loaded!.count, Self.test.count)
        XCTAssertEqual(loaded![0], Self.test[0])
        XCTAssertEqual(loaded![1], Self.test[1])
        XCTAssertEqual(loaded![2], Self.test[2])
    }
}
