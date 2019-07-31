//
//  ColourList.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-17.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI

let colourList = [
    "#f0f8ff": "AliceBlue",
    "#faebd7": "AntiqueWhite",
    "#00f0ff": "Aqua",
    "#7fffd4": "Aquamarine",
    "#f0ffff": "Azure",
    "#f5f5dc": "Beige",
    "#ffe4c4": "Bisque",
    "#000000": "Black",
    "#ffebcd": "BlanchedAlmond",
    "#0000ff": "Blue",
    "#8a2be2": "BlueViolet",
    "#a52a2a": "Brown",
    "#deb887": "BurlyWood",
    "#5f9ea0": "CadetBlue",
    "#7fff00": "Chartreuse",
    "#d2691e": "Chocolate",
    "#ff7f50": "Coral",
    "#6495ed": "CornflowerBlue",
    "#fff8dc": "Cornsilk",
    "#dc143c": "Crimson",
    "#00ffff": "Cyan",
    "#00008b": "DarkBlue",
    "#008b8b": "DarkCyan",
    "#b8860b": "DarkGoldenRod",
    "#a9a9a9": "DarkGray",
    "#006400": "DarkGreen",
    "#bdb76b": "DarkKhaki",
    "#8b008b": "DarkMagenta",
    "#556b2f": "DarkOliveGreen",
    "#ff8c00": "DarkOrange",
    "#9932cc": "DarkOrchid",
    "#8b0000": "DarkRed",
    "#e9967a": "DarkSalmon",
    "#8fbc8f": "DarkSeaGreen",
    "#483d8b": "DarkSlateBlue",
    "#2f4f4f": "DarkSlateGray",
    "#00ced1": "DarkTurquoise",
    "#9400d3": "DarkViolet",
    "#ff1493": "DeepPink",
    "#00bfff": "DeepSkyBlue",
    "#696969": "DimGray",
    "#1e90ff": "DodgerBlue",
    "#b22222": "FireBrick",
    "#fffaf0": "FloralWhite",
    "#228b22": "ForestGreen",
    "#dcdcdc": "Gainsboro",
    "#f8f8ff": "GhostWhite",
    "#ffd700": "Gold",
    "#daa520": "Goldenrod",
    "#808080": "Gray",
    "#00ff00": "Green",
    "#adff2f": "GreenYellow",
    "#f0fff0": "HoneyDew",
    "#ff69b4": "HotPink",
    "#cd5c5c": "IndianRed",
    "#4b0082": "Indigo",
    "#fffff0": "Ivory",
    "#f0e68c": "Khaki",
    "#e6e6fa": "Lavender",
    "#fff0f5": "LavenderBlush",
    "#7cfc00": "LawnGreen",
    "#fffacd": "LemonChiffon",
    "#add8e6": "LightBlue",
    "#f08080": "LightCoral",
    "#e0ffff": "LightCyan",
    "#fafad2": "LightGoldenRodYellow",
    "#d3d3d3": "LightGray",
    "#90ee90": "LightGreen",
    "#ffb6c1": "LightPink",
    "#ffa07a": "LightSalmon",
    "#20b2aa": "LightSeaGreen",
    "#87cefa": "LightSkyBlue",
    "#778899": "LightSlateGray",
    "#b0c4de": "LightSteelBlue",
    "#ffffe0": "LightYellow",
    "#32cd32": "LimeGreen",
    "#faf0e6": "Linen",
    "#ff00ff": "Magenta",
    "#800000": "Maroon",
    "#66cdaa": "MediumAquaMarine",
    "#0000cd": "MediumBlue",
    "#ba55d3": "MediumOrchid",
    "#9370db": "MediumPurple",
    "#3cb371": "MediumSeaGreen",
    "#7b68ee": "MediumSlateBlue",
    "#00fa9a": "MediumSpringGreen",
    "#48d1cc": "MediumTurquoise",
    "#c71585": "MediumVioletRed",
    "#191970": "MidnightBlue",
    "#f5fffa": "MintCream",
    "#ffe4e1": "MistyRose",
    "#ffe4b5": "Moccasin",
    "#ffdead": "NavajoWhite",
    "#000080": "Navy",
    "#fdf5e6": "OldLace",
    "#808000": "Olive",
    "#6b8e23": "OliveDrab",
    "#ffa500": "Orange",
    "#ff4500": "OrangeRed",
    "#da70d6": "Orchid",
    "#eee8aa": "PaleGoldenRod",
    "#98fb98": "PaleGreen",
    "#aeeeee": "PaleTurquoise",
    "#db7093": "PaleVioletRed",
    "#ffefd5": "PapayaWhip",
    "#cd853f": "Peru",
    "#ffc0cb": "Pink",
    "#dda0dd": "Plum",
    "#b0e0e6": "PowderBlue",
    "#800080": "Purple",
    "#663399": "RebeccaPurple",
    "#ff0000": "Red",
    "#bc8f8f": "RosyBrown",
    "#4169e1": "RoyalBlue",
    "#8b4513": "SaddleBrown",
    "#fa8072": "Salmon",
    "#f4a460": "SandyBrown",
    "#2e8b57": "SeaGreen",
    "#fff5ee": "SeaShell",
    "#a0522d": "Sienna",
    "#c0c0c0": "Silver",
    "#87ceeb": "SkyBlue",
    "#6a5acd": "SlateBlue",
    "#708090": "SlateGray",
    "#fffafa": "Snow",
    "#00ff7f": "SpringGreen",
    "#4682b4": "SteelBlue",
    "#d2b48c": "Tan",
    "#008080": "Teal",
    "#dfbfd8": "Thistle",
    "#ff6347": "Tomato",
    "#40e0d0": "Turquoise",
    "#ee82ee": "Violet",
    "#f5deb3": "Wheat",
    "#ffffff": "White",
    "#f5f5f5": "WhiteSmoke",
    "#ffff00": "Yellow",
    "#9acd32": "YellowGreen"
]

fileprivate let colourSynonyms = [
    "darkgray":         [ "Darkgrey" ],
    "gray":             [ "Grey" ],
    "lightgray":        [ "LightGrey" ],
    "lightslategray":   [ "LightSlateGrey" ],
    "magenta":          [ "Fuschia" ],
    "slategray":        [ "SlateGrey" ]
]

// hex to lower case colour names
fileprivate var hexList: [ String: String ] = [:]

// lower case to camel case translation
fileprivate var camelNames: [ String: String ] = [:]

fileprivate func makeHexList() {
    for (hex, colour) in colourList {
        hexList[ colour.lowercased() ] = hex
        camelNames[ colour.lowercased() ] = colour
        if colourSynonyms[ colour.lowercased() ] != nil {
            for syn in colourSynonyms[ colour.lowercased() ]! {
                hexList[ syn.lowercased() ] = hex
                camelNames[ syn.lowercased() ] = syn
            }
        }
    }
}

//
//  Return a list of colour names that match the name
//
func coloursMatching(_ name: String, sortByIntensity: Bool = false) -> [ String ] {
    var namesMatching: [String:Int] = [:]
    let lcName = name.lowercased()
    
    if hexList.count == 0 { makeHexList() }
    
    for (key, hex) in hexList {
        if key.contains(lcName) {
            let newKey = (camelNames[key] != nil) ? camelNames[key]! : key
            if sortByIntensity {
                namesMatching[ newKey ] = ColourItem.intensity(hex)
            }
            else {
                namesMatching[ newKey ] = 0
            }
        }
    }
    
    if sortByIntensity {
        return namesMatching.keys.sorted(by: { namesMatching[$0]! > namesMatching[$1]! }).compactMap({$0})
    }
    else {
        return namesMatching.keys.sorted()
    }
}

//
// Lookup the hex value in hexList
//
func hexLookup(_ name: String) -> String? {
    if hexList.count == 0 { makeHexList() }
    
    return hexList[ name.lowercased() ]
}

//
// Lookup the Color associated with a name
//

fileprivate var colorList: [ String:Color ] = [:]

func colorLookup(_ name: String) -> Color? {
    let lcName = name.lowercased()
    
    if colorList[ lcName ] == nil {
        let hex = hexLookup(lcName)
        if hex == nil { return nil }
        colorList[ lcName ] = ColourItem(hex: hex)?.color
    }
    return colorList[ lcName ]
}
