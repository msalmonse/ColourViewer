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

struct ColourItem: Identifiable, Equatable, Codable {
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

    // Calculate the Rec 709 luma of a colour
    var luma: Int { return Self.RGBtoLuma(Int(red), Int(green), Int(blue)) }

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

    /// Initialize a ColourItem with no data
    init() {
        self.label = "clear"
        self.color = Color.clear
        self.red = 0
        self.green = 0
        self.blue = 0
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
    static func == (lhs: ColourItem, rhs: ColourItem) -> Bool {
        return lhs.red == rhs.red && lhs.green == rhs.green && lhs.blue == rhs.blue
    }

    // Calculate the Rec 709 luma from red, green and blue
    private static func RGBtoLuma(_ r: Int, _ g: Int, _ b: Int) -> Int {
        return 2126 * r + 7152 * g + 722 * b
    }

    // Calculate the Rec 709 luma from a hex code
    static func luma(_ hex: String?) -> Int {
        var r = 0
        var g = 0
        var b = 0

        if !hexToRGB(hex: hex, r: &r, g: &g, b: &b ) { return -1 }

        return RGBtoLuma(r, g, b)
    }

    // Stuff for encoding and decoding
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let r = try values.decode(Int.self, forKey: .red)
        let g = try values.decode(Int.self, forKey: .green)
        let b = try values.decode(Int.self, forKey: .blue)

        self.init(red: r, green: g, blue: b)
    }
}

/// A wrapper for ColourItem that can be used with SwiftUI

class ObservableColourItem: Combine.ObservableObject, Identifiable {
    var objectWillChange = ObservableObjectPublisher()
    // Callback closure
    var hasChanged: ((ColourItem) -> Void)? = nil

    var id = UUID()

    private(set) var colourItem = ColourItem(hex: "#000") {
        willSet { objectWillChange.send() }
        didSet { if hasChanged != nil { hasChanged!(colourItem!) } }
    }

    /// Return the internal ColourItem
    var unwrap: ColourItem {
        return colourItem!
    }

    /// Update the ColourItem using red, green and blue
    func setRGB(red: Int, green: Int, blue: Int) {
        if colourItem == nil ||
            red != Int(colourItem!.red) ||
            green != Int(colourItem!.green) ||
            blue != colourItem!.blue {
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
            var newCI: ColourItem? = nil
            if colourItem == nil || colourItem!.label != newValue {
                if newValue.hasPrefix("#") {
                    newCI = ColourItem(hex: newValue)
                } else {
                    let hex = hexLookup(newValue)
                    newCI = ColourItem(hex: hex)
                }
                if newCI == nil { newCI = ColourItem() }
                colourItem = newCI
            }
        }
    }

    /// Create an object with a ColourItem equal to label
    convenience init(label: String) {
        self.init()
        self.label = label
    }
}
