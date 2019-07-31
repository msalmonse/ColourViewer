//
//  NumberAndString.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class IntAndString: Combine.ObservableObject, Identifiable {
    private var format: String = ""
    private var base = 0
    
    let id = UUID()
    let minNumber: Int
    let maxNumber: Int

    var objectWillChange = ObservableObjectPublisher()
    var hasChanged: ((Int) -> ())? = nil
    
    var number: Int {
        willSet { objectWillChange.send() }
        didSet {
            if (!inRange(number)) { number = oldValue }
            else if (number != oldValue) {
                formatString()
                if hasChanged != nil { hasChanged!(number) }
            }
        }
    }
    
    var string: String = "" {
        willSet { objectWillChange.send() }
        didSet {
            if (string != oldValue) {
                let newNumber = Int(string, radix: base)
                if newNumber != nil && inRange(newNumber!) {
                    number = newNumber!
                }
                else { formatString() }
            }
        }
    }
    
    private func inRange(_ num: Int) -> Bool { num >= minNumber && num <= maxNumber }
    
    private func formatString() {
        string = (format == "") ? "" : String(format: format, number)
    }

    func setRadix(radix: Radix) {
        format = radix.format
        base = radix.base
        formatString()
    }
    
    init(number: Int, min: Int = Int.min, max: Int = Int.max, radix: Radix = .decimal) {
        self.number = number
        self.minNumber = min
        self.maxNumber = max
        setRadix(radix: radix)
    }
}

// Default values for RGB int's
class RGBandString: IntAndString {
    init(_ number: Int = 0) { super.init(number: number, min: 0, max: 255) }
}

class DoubleAndString: Combine.ObservableObject, Identifiable {
    private var format: String = "%.2f"
    
    let id = UUID()
    let minNumber: Double
    let maxNumber: Double
    var wrapMax = 0.0 {
        didSet { doWrap = true }
    }
    var doWrap = false

    var objectWillChange = ObservableObjectPublisher()
    var hasChanged: ((Double) -> ())? = nil
    
    var number: Double {
        willSet { objectWillChange.send() }
        didSet {
            if doWrap { wrapNumber() }
            if (!inRange(number)) { number = oldValue }
            else if (number != oldValue) {
                formatString()
                if hasChanged != nil { hasChanged!(number) }
            }
        }
    }
    
    var string: String = "" {
        willSet { objectWillChange.send() }
        didSet {
            if (string != oldValue) {
                let newNumber = Double(string)
                if newNumber != nil && (doWrap || inRange(newNumber!)) {
                    number = newNumber!
                }
                else { formatString() }
            }
        }
    }
    
    private func inRange(_ num: Double) -> Bool { num >= minNumber && num <= maxNumber }
    
    private func formatString() {
        string = (format == "") ? "" : String(format: format, number)
    }
    
    private func wrapNumber() {
        if inRange(number) || minNumber == -Double.infinity { return }
        var val = number - minNumber
        val = val.truncatingRemainder(dividingBy: wrapMax - minNumber)
        if val < 0 { number = val + wrapMax}
        else { number = val + minNumber }
    }
    
    init(number: Double, min: Double = -Double.infinity, max: Double = Double.infinity) {
        self.number = number
        self.minNumber = min
        self.maxNumber = max
        formatString()
    }
}

class PerCentAndString: DoubleAndString {
    init(percent: Double = 0.0) { super.init(number: percent, min: 0.0, max: 100.0)}
}

class DegreesAndString: DoubleAndString {
    init(degrees: Double = 0.0) {
        super.init(number: degrees, min: 0.0, max: 359.99)
        self.wrapMax = 360.0
    }
}
