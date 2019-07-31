//
//  ColourConvert.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-16.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import UIKit

func HSBfromRGB(red: Int, green: Int, blue: Int,
                hue: inout Double, saturation: inout Double, brightness: inout Double) {
    
    let colour = UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    
    var h: CGFloat = 0.0
    var s: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 0.0
    
    colour.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    
    hue = (h == 1.0) ? 0.0 : (Double(exactly: 36000.0 * h)!).rounded()/100.0
    saturation = (Double(exactly: 10000.0 * s)!).rounded()/100.0
    brightness = (Double(exactly: 10000.0 * b)!).rounded()/100.0
}

fileprivate func CGFloatToInt(_ value: CGFloat) -> Int {
    let returnValue = Int(trunc(value * 256.0))
    return (returnValue > 255) ? 255 : returnValue
}

func RGBfromHSB(hue: Double, saturation: Double, brightness: Double,
                red: inout Int, green: inout Int, blue: inout Int) {
    let colour = UIColor(hue: CGFloat(hue/360.0), saturation: CGFloat(saturation/100.0), brightness: CGFloat(brightness/100.0), alpha: 1.0)
    
    var r: CGFloat = 0.0
    var g: CGFloat = 0.0
    var b: CGFloat = 0.0
    var a: CGFloat = 0.0
    
    colour.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    red = CGFloatToInt(r)
    green = CGFloatToInt(g)
    blue = CGFloatToInt(b)
}
