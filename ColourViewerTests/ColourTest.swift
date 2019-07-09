//
//  ColourTest.swift
//  ColourViewerTests
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import XCTest

import XCTest
@testable import ColourViewer
import UIKit

fileprivate struct ValueToTest {
    let r: Int
    let g: Int
    let b: Int
    let h: Double
    let s: Double
    let l: Double
    let rgb: String
}

fileprivate let values: [ValueToTest] = [
    ValueToTest(r:   0, g:   0, b:   0, h:   0.0, s:   0.0, l:   0.0, rgb: "000000"),
    ValueToTest(r: 255, g: 255, b: 255, h:   0.0, s:   0.0, l: 100.0, rgb: "ffffff"),
    ValueToTest(r: 255, g:   0, b:   0, h:   0.0, s: 100.0, l:  50.0, rgb: "ff0000"),
    ValueToTest(r: 255, g: 255, b:   0, h:  60.0, s: 100.0, l:  50.0, rgb: "ffff00"),
    ValueToTest(r:   0, g: 255, b:   0, h: 120.0, s: 100.0, l:  50.0, rgb: "00ff00"),
    ValueToTest(r:   0, g: 255, b: 255, h: 180.0, s: 100.0, l:  50.0, rgb: "00ffff"),
    ValueToTest(r:   0, g:   0, b: 255, h: 240.0, s: 100.0, l:  50.0, rgb: "0000ff"),
    ValueToTest(r: 255, g:   0, b: 255, h: 300.0, s: 100.0, l:  50.0, rgb: "ff00ff"),
    ValueToTest(r: 192, g: 255, b: 238, h: 163.0, s: 100.0, l:  87.0, rgb: "c0ffee"),
    ValueToTest(r: 206, g: 239, b: 229, h: 163.0, s:  50.0, l:  87.0, rgb: "ceefe5"),
    ValueToTest(r:  64, g: 192, b: 155, h: 163.0, s:  50.0, l:  50.0, rgb: "40c09b"),
    ValueToTest(r: 102, g: 153, b: 204, h: 210.0, s:  50.0, l:  60.0, rgb: "6699cc"),
    ValueToTest(r:  17, g:  25, b:  34, h: 210.0, s:  33.0, l:  10.0, rgb: "111922")
]

class ColourTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRGB() {
        // Check that the combined string is correct
        let colour = Colour()
        
        for val in values {
            colour.red = val.r
            colour.green = val.g
            colour.blue = val.b
            
            XCTAssertEqual(colour.hue, val.h, accuracy: 2.0, "for \(val.rgb)")
            XCTAssertEqual(colour.saturation, val.s, accuracy: 3.0, "for \(val.rgb)")
            XCTAssertEqual(colour.lightness, val.l, accuracy: 1.0, "for \(val.rgb)")
            XCTAssertEqual(colour.rgb, val.rgb)
        }
        
        // Check the UIColor generated
        let uicolor = Colour(red: 255, green: 255, blue: 0).color
        XCTAssert(uicolor == UIColor.yellow)
    }
    
    func testHSL() {
        // Check that the combined string is correct
        let colour = Colour()
        
        for val in values {
            colour.hue = val.h
            colour.saturation = val.s
            colour.lightness = val.l
            
            XCTAssertEqual(Double(colour.red), Double(val.r), accuracy: 5.0, "for \(val.rgb)")
            XCTAssertEqual(Double(colour.green), Double(val.g), accuracy: 5.0, "for \(val.rgb)")
            XCTAssertEqual(Double(colour.blue), Double(val.b), accuracy: 5.0, "for \(val.rgb)")
        }
    }
    
    //    func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    //    }
    
    //    func testPerformanceExample() {
    // This is an example of a performance test case.
    //        self.measure {
    // Put the code you want to measure the time of here.
    //        }
    //    }
    
}
