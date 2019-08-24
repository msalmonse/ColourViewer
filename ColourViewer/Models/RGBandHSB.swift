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

// struct to hold all numbers
struct previousRGBandHSB {
    let red: Int
    let green: Int
    let blue: Int
    let hue: Double
    let saturation: Double
    let brightness: Double
}

fileprivate enum UpdatingSource {
    case none, rgb, hsb, color, restore
}

/// This class combines the RGB, HSB and Colour values. Updating one updates the other two

class RGBandHSB {
    // RGB values
    let red = RGBandString()
    let blue = RGBandString()
    let green = RGBandString()

    // HSB values
    let hue = DegreesAndString()
    let saturation = PerCentAndString()
    let brightness = PerCentAndString()

    // Colour Item
    var colourItem = ObservableColourItem()

    // Short cut to color
    var color: Color? {
        return colourItem.color
    }

    // Updating the label updates the ColourItem
    var label: String {
        get { return colourItem.label }
        set {
            colourItem.label = newValue
            updateFromColourItem()
        }
    }

    // Undo Manager for RGBandHSB
    static let unMan = UndoManager()

    private var updatingFrom: UpdatingSource = .none    // prevent loops between RGB & HSB

    // Update the HSB values
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

    /// Called by updates in RGB elements
    private func updateFromRGB() {
        if updatingFrom != .none { return }
        updatingFrom = .rgb

        updateHSB()
        updateColourItem()
        registerUndo()

        updatingFrom = .none
    }

    // Called by updates in the HSB elements
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
        registerUndo()

        updatingFrom = .none
    }

    // Called when colourItem updates
    private func updateFromColourItem() {
        if updatingFrom != .none { return }
        updatingFrom = .color

        red.number = colourItem.red
        green.number = colourItem.green
        blue.number = colourItem.blue

        updateHSB()
        registerUndo()

        updatingFrom = .none
    }

    // Update ColourItem to changes in RGB
    private func updateColourItem() {
        if updatingFrom == .color { return }
        colourItem.setRGB(red: red.number, green: green.number, blue: blue.number)
    }

    // Restore to previous state: Undo or Redo
    func restore(_ previous: previousRGBandHSB) {
        if updatingFrom != .none { return }
        updatingFrom = .restore

        red.number = previous.red
        green.number = previous.green
        blue.number = previous.blue
        hue.number = previous.hue
        saturation.number = previous.saturation
        brightness.number = previous.brightness

        // Undo registered now is a redo
        registerUndo()

        updateColourItem()

        updatingFrom = .none
    }

    // Register an undo event
    private func registerUndo() {
        let previous = previousRGBandHSB(
            red: red.previous,
            green: green.previous,
            blue: blue.previous,
            hue: hue.previous,
            saturation: saturation.previous,
            brightness: brightness.previous
        )
        Self.unMan.registerUndo(withTarget: self, handler: { $0.restore(previous) })
    }

    /// Initializer
    /// Parameters:
    ///     red:        red component
    ///     green:    green component
    ///     blue:      blue component

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

    // Create an RGBandHSB with random colours
    static var random: RGBandHSB {
        return RGBandHSB(
                red: Int.random(in: 0...255),
                green: Int.random(in: 0...255),
                blue: Int.random(in: 0...255)
        )
    }

    // Set the radix in the RGB components
    func setRadix(radix: Radix) {
        red.setRadix(radix: radix)
        green.setRadix(radix: radix)
        blue.setRadix(radix: radix)
    }
}
