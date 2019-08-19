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

/// This class is a combined Int and String. Updating either will update the other provided that the values are valid

class IntAndString: Combine.ObservableObject, Identifiable {
    /// format and base are used for converting between Int and String
    private var format: String = ""
    private var base = 0

    let id = UUID()
    // Allowable range for number
    let minNumber: Int
    let maxNumber: Int

    // Notifiers, a publisher for SwiftUI and a callback
    var objectWillChange = ObservableObjectPublisher()
    var hasChanged: ((Int) -> Void)? = nil

    // The Int part, check for validity and update string
    var number: Int {
        willSet { objectWillChange.send() }
        didSet {
            if !inRange(number) {
                number = oldValue
            } else if number != oldValue {
                formatString()
                if hasChanged != nil { hasChanged!(number) }
            }
        }
    }

    // The string part, check for validity and update number
    var string: String = "" {
        willSet { objectWillChange.send() }
        didSet {
            if string != oldValue {
                let newNumber = Int(string, radix: base)
                if newNumber != nil && inRange(newNumber!) {
                    number = newNumber!
                } else { formatString() }
            }
        }
    }

    // Check limits
    private func inRange(_ num: Int) -> Bool { num >= minNumber && num <= maxNumber }

    // Format string
    private func formatString() {
        string = (format == "") ? "" : String(format: format, number)
    }

    // Set the base and format according to the radix
    func setRadix(radix: Radix) {
        format = radix.format
        base = radix.base
        formatString()
    }

    /// Initializer
    /// Parameters:
    ///     number:     Initial value for number
    ///     min:            Minimum limit
    ///     max:           Maximum limit
    ///     radix:          Initial radix for number

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

/// This class is a combined Double and String, updating the one updates the other provided that the values are valid

class DoubleAndString: Combine.ObservableObject, Identifiable {
    private var format: String = "%.1f"

    let id = UUID()
    // Limits for value
    let minNumber: Double
    let maxNumber: Double
    // Should the number wrap around if it is too big or small?
    var wrapMax = 0.0 {
        didSet { doWrap = true }
    }
    var doWrap = false

    // Notifiers
    var objectWillChange = ObservableObjectPublisher()
    var hasChanged: ((Double) -> Void)? = nil

    // The number part
    var number: Double {
        willSet { objectWillChange.send() }
        didSet {
            if doWrap { wrapNumber() }
            if !inRange(number) {
                number = oldValue
            } else if number != oldValue {
                formatString()
                if hasChanged != nil { hasChanged!(number) }
            }
        }
    }

    // The string part
    var string: String = "" {
        willSet { objectWillChange.send() }
        didSet {
            if string != oldValue {
                let newNumber = Double(string)
                if newNumber != nil && (doWrap || inRange(newNumber!)) {
                    number = newNumber!
                } else { formatString() }
            }
        }
    }

    // Check limits
    private func inRange(_ num: Double) -> Bool { num >= minNumber && num <= maxNumber }

    // Format string
    private func formatString() {
        string = (format == "") ? "" : String(format: format, number)
    }

    // Wrap the number around so that it is between min and wrapMax
    private func wrapNumber() {
        if inRange(number) || minNumber == -Double.infinity { return }
        var val = number - minNumber
        val = val.truncatingRemainder(dividingBy: wrapMax - minNumber)
        if val < 0 { number = val + wrapMax }
        else { number = val + minNumber }
    }

    /// Initializer
    /// Parameters:
    ///     number:     Initial value for number
    ///     min:            Minimum limit
    ///     max:           Maximum limit

    init(number: Double, min: Double = -Double.infinity, max: Double = Double.infinity) {
        self.number = number
        self.minNumber = min
        self.maxNumber = max
        formatString()
    }
}

// For per cent values
class PerCentAndString: DoubleAndString {
    init(percent: Double = 0.0) { super.init(number: percent, min: 0.0, max: 100.0)}
}

// For degrees
class DegreesAndString: DoubleAndString {
    init(degrees: Double = 0.0) {
        super.init(number: degrees, min: 0.0, max: 359.99)
        self.wrapMax = 360.0
    }
}
