//
//  ColourItem.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import Combine

/// Extension to allow creating Color obects with Int RGB

extension Color {
    init(red: Int, green: Int, blue: Int) {
        let newRed = Double(red)/255.0
        let newGreen = Double(green)/255.0
        let newBlue = Double(blue)/255.0
        
        self.init(red: newRed, green: newGreen, blue: newBlue, opacity: 1.0)
    }
}

/// Convert a hex substring to an Int
/// Return true on success
///
/// Parameters:
///     from:     base string
///     first:      first character from beginning to use
///     count:   number of characters
///     to:         reference to result

fileprivate func hexToInt(from: String, first: Int, count: Int, to: inout Int) -> Bool {
    let start = from.index(from.startIndex, offsetBy: first)
    let end = from.index(from.startIndex, offsetBy: first + count)
    let subFrom = from[start..<end]
    guard let val = Int(subFrom, radix: 16) else { return false }
    to = val
    return true
}

/// Convert a hex string to red, green & blue
/// Expectd formats "#rgb" or "#rrggbb"
/// Returns true on success
///
/// Parameters:
///     hex:        hex string
///     r:             reference to red colour
///     g:            reference to green colour
///     b:            reference to blue colour

fileprivate func hexToRGB(hex: String?, r: inout Int, g: inout Int, b: inout Int) -> Bool {
    if hex == nil || !hex!.hasPrefix("#") { return false }
    switch hex!.count {
    case 4:     // #rgb
        if  !hexToInt(from: hex!, first: 1, count: 1, to: &r) ||
            !hexToInt(from: hex!, first: 2, count: 1, to: &g) ||
            !hexToInt(from: hex!, first: 3, count: 1, to: &b) { return false }
        r *= 17
        g *= 17
        b *= 17
    case 7:     // #rrggbb
        if  !hexToInt(from: hex!, first: 1, count: 2, to: &r) ||
            !hexToInt(from: hex!, first: 3, count: 2, to: &g) ||
            !hexToInt(from: hex!, first: 5, count: 2, to: &b) { return false }
    default:
        return false
    }

    return true
}

/// A struct to hold a Color, a label and the componets used to create it

struct ColourItem: Identifiable, Equatable {
    /// Format used to convert red, green and blue to a hex string
    static let format = "#%02x%02x%02x"
    
    let id = UUID()
    let label: String
    let color: Color
    let red: UInt8
    let green: UInt8
    let blue: UInt8

    /// Create a UIColor from the components
    var uiColor: UIColor {
        UIColor(
            red: CGFloat(red)/255.0,
            green: CGFloat(green)/255.0,
            blue: CGFloat(blue)/255.0,
            alpha: 1.0
        )
    }
    
    /// Calculate the intensity of a colour
    var intensity: Int {
        return Int(red) + Int(green) + Int(blue) + 2 * Int(max(red, green, blue))
    }
    
    /// Initialize a ColourItem
    ///
    /// Parameters
    ///     red:        red component
    ///     green:     green component
    ///     blue:       blue component
    ///     label:      name of the colour or hex code
    
    init(red: Int, green: Int, blue: Int, label: String) {
        self.label = label
        self.color = Color(red: red, green: green, blue: blue)
        self.red = UInt8(red)
        self.green = UInt8(green)
        self.blue = UInt8(blue)
    }
    
    /// As above but calculate the label
    init(red: Int, green: Int, blue: Int) {
        let hexStr = String(format: Self.format, red, green, blue)
        let name = colourList[hexStr]
        self.init(red: red, green: green, blue: blue, label: (name != nil) ? name! : hexStr)
    }
    
    /// Initialize using a hex colour string: "#rrggbb"
    init?(hex: String?) {
        var r = 0
        var g = 0
        var b = 0
        
        if !hexToRGB(hex: hex, r: &r, g: &g, b: &b ) { return nil }
        
        self.init(red: r, green: g, blue: b)
    }
    
    /// Compare two ColourItem's
    static func ==(lhs: ColourItem, rhs: ColourItem) -> Bool {
        return lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue
    }
    
    /// Calculate the intensity from a hex code
    static func intensity(_ hex: String?) -> Int {
        var r = 0
        var g = 0
        var b = 0
        
        if !hexToRGB(hex: hex, r: &r, g: &g, b: &b ) { return -1 }
        
        return r + b + g + 2 * max(r, g, b)
    }
}

/// A wrapper for ColourItem that can be used with SwiftUI

class ObservableColourItem: Combine.ObservableObject, Identifiable {
    var objectWillChange = ObservableObjectPublisher()
    // Callback closure
    var hasChanged: ((ColourItem) -> ())? = nil

    var id = UUID()
    
    private(set) var colourItem = ColourItem(hex: "#000") {
        willSet {
            objectWillChange.send()
        }
        didSet {
            if hasChanged != nil { hasChanged!(colourItem!) }
        }
    }
    
    /// Return the internal ColourItem
    var unbind: ColourItem {
        return colourItem!
    }

    /// Update the ColourItem using red, green and blue
    func setRGB(red: Int, green: Int, blue: Int) {
        if colourItem == nil ||
            red != Int(colourItem!.red) ||
            green != Int(colourItem!.green) ||
            blue != colourItem!.blue
        {
            colourItem = ColourItem(red: red, green: green, blue: blue)
        }
    }
    
    var color: Color { return colourItem!.color }
    
    var red: Int { return Int(colourItem!.red) }
    var green: Int { return Int(colourItem!.green) }
    var blue: Int { return Int(colourItem!.blue) }

    var label: String {
        get { return (colourItem == nil) ? "" : colourItem!.label }
        /// Setting the label will update the internal ColourItem
        set {
            if colourItem == nil || colourItem!.label != newValue {
                if newValue.hasPrefix("#") {
                    colourItem = ColourItem(hex: newValue)
                }
                else {
                    let hex = hexLookup(newValue)
                    colourItem = ColourItem(hex: hex)
                }
            }
        }
    }
    
    /// Create an object with a ColourItem eqal to label
    convenience init(label: String) {
        self.init()
        self.label = label
    }
}
