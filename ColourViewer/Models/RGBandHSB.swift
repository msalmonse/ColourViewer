//
//  RGBandHSB.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-26.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

fileprivate enum UpdatingSource {
    case none, rgb, hsb, color
}

class RGBandHSB {
    // RGB
    let red = RGBandString()
    let blue = RGBandString()
    let green = RGBandString()
    
    // HSB
    let hue = DegreesAndString()
    let saturation = PerCentAndString()
    let brightness = PerCentAndString()
    
    // Colour Item
    var colourItem = ObservableColourItem()
    
    var color: Color? {
        return colourItem.color
    }
    
    var label: String {
        get { return colourItem.label }
        set {
            colourItem.label = newValue
            updateFromColourItem()
        }
    }
    
    private var updatingFrom: UpdatingSource = .none    // prevent loops between RGB & HSB
    
    private func updateHSB() {
        HSBfromRGB(
                    red: red.number,
                    green: green.number,
                    blue: blue.number,
                    hue: &hue.number,
                    saturation: &saturation.number,
                    brightness: &brightness.number
                )
    }
    
    private func updateFromRGB() {
        if updatingFrom != .none { return }
        updatingFrom = .rgb

        updateHSB()
        updateColourItem()
        updatingFrom = .none
    }
    
    private func updateFromHSB() {
        if updatingFrom != .none { return }
        updatingFrom = .hsb

        RGBfromHSB(
            hue: hue.number,
            saturation: saturation.number,
            brightness: brightness.number,
            red: &red.number,
            green: &green.number,
            blue: &blue.number
        )
        
        updateColourItem()
        updatingFrom = .none
    }
    
    private func updateFromColourItem() {
        if updatingFrom != .none { return }
        updatingFrom = .color

        red.number = colourItem.red
        green.number = colourItem.green
        blue.number = colourItem.blue
        updateHSB()
        
        updatingFrom = .none
    }
    
    private func updateColourItem() {
        if updatingFrom == .color { return }
        colourItem.setRGB(red: red.number, green: green.number, blue: blue.number)
    }
    
    init(red: Int = 0, green: Int = 0, blue: Int = 0) {
        self.red.number = red
        self.green.number = green
        self.blue.number = blue
        updateFromRGB()
        
        // Set call backs
        self.red.hasChanged = { value in self.updateFromRGB() }
        self.green.hasChanged = { value in self.updateFromRGB() }
        self.blue.hasChanged = { value in self.updateFromRGB() }
        
        self.hue.hasChanged = { value in self.updateFromHSB() }
        self.saturation.hasChanged = { value in self.updateFromHSB() }
        self.brightness.hasChanged = { value in self.updateFromHSB() }
        
        self.colourItem.hasChanged = { value in self.updateFromColourItem() }
    }

    static var random: RGBandHSB {
        return RGBandHSB(
                red: Int.random(in: 0...255),
                green: Int.random(in: 0...255),
                blue: Int.random(in: 0...255)
        )
    }

    func setRadix(radix: Radix) {
        red.setRadix(radix: radix)
        green.setRadix(radix: radix)
        blue.setRadix(radix: radix)
    }
}
