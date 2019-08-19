//
//  ColourConvert.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-16.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable function_parameter_count

/// Use UIColour to convert between red, green and blue, and hue, satuation and brightness
/// N.B. there is no return value, inout parameters are used to return hue, satuation and brightness
///
/// Parameters:
///     red:                red component
///     green:            green component
///     blue:              blue component
///     hue:               hue reference
///     saturation:     saturation reference
///     brightness:     brightness reference

func HSBfromRGB(red: Int, green: Int, blue: Int,
                hue: inout Double, saturation: inout Double, brightness: inout Double) {

    let colour = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)

    var h: CGFloat = 0.0
    var s: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 0.0

    colour.getHue(&h, saturation: &s, brightness: &b, alpha: &a)

    // Round results to one decimal place
    hue = (h == 1.0) ? 0.0 : (Double(exactly: 3600.0 * h)!).rounded()/10.0
    saturation = (Double(exactly: 1000.0 * s)!).rounded()/10.0
    brightness = (Double(exactly: 1000.0 * b)!).rounded()/10.0
}

/// Convert from CGFloat to 0...255
fileprivate func CGFloatToInt(_ value: CGFloat) -> Int {
    let returnValue = Int(trunc(value * 256.0))
    return (returnValue > 255) ? 255 : returnValue
}

/// Use UIColor to convert between hue, satuation and brightness, and red, green and blue,
/// N.B. there is no return value, inout parameters are used to return hue, satuation and brightness
///
/// Parameters:
///     hue:               hue component
///     saturation:     saturation component
///     brightness:     brightness component
///     red:                red reference
///     green:            green reference
///     blue:              blue reference

func RGBfromHSB(hue: Double, saturation: Double, brightness: Double,
                red: inout Int, green: inout Int, blue: inout Int) {
    let colour = UIColor(
        hue: CGFloat(hue/360.0),
        saturation: CGFloat(saturation/100.0),
        brightness: CGFloat(brightness/100.0),
        alpha: 1.0
    )

    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 0.0

    colour.getRed(&r, green: &g, blue: &b, alpha: &a)

    red = CGFloatToInt(r)
    green = CGFloatToInt(g)
    blue = CGFloatToInt(b)
}
