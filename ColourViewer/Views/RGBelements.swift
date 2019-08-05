//
//  RGBelements.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// Display and edit the RGB components
///
/// Parameters:
///     redElement:       element for the red component
///     greenElement:   element for the green component
///     blueElement:     element for the blue component
///     font:           the main font size to use
///     height:                desired height of view
///     width:                 derired width of view

struct RGBelements: View {
    /// Set the Radix to be used for the Int values
    /// Parameter:
    ///     base:   the base for the integers (8, 10 or 16)
    
    private func setRadices(base: Int) {
        let radix = Radix.radix(for: base)

        redElement.setRadix(radix: radix)
        greenElement.setRadix(radix: radix)
        blueElement.setRadix(radix: radix)
    }
    
    @ObservedObject var redElement: IntAndString
    @ObservedObject var greenElement: IntAndString
    @ObservedObject var blueElement: IntAndString
    var font: Font
    var height: CGFloat
    var width: CGFloat
    
    /// Base for the elements
    @ObservedObject var base = ObservableInt(10)

    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            Section(header: Text("RGB").font(.subheadline)) {
                IntElement(
                    label: "Red",
                    element: redElement,
                    font: font,
                    height: height/5,
                    width: width
                )
                
                IntElement(
                    label: "Green",
                    element: greenElement,
                    font: font,
                    height: height/5,
                    width: width
                )
                
                IntElement(
                    label: "Blue",
                    element: blueElement,
                    font: font,
                    height: height/5,
                    width: width
                )
                
                /// Selector for the base and radix
                Picker("Radix", selection: $base.number) {
                    Text("Dec").tag(10)
                    Text("Hex").tag(16)
                    Text("Oct").tag(8)
                }
                .pickerStyle(SegmentedPickerStyle())
                .font(smallerFont(font, by: 2))
                .frame(width: width * 0.4)
                // receiver for changes in base
                .onReceive(base.publisher, perform: { self.setRadices(base: $0) })
            }
        }
        .modifier(sectionBackground())
        
    }
}

#if DEBUG
struct RGBelements_Previews: PreviewProvider {
    @ObservedObject static var red = IntAndString(number: 51)
    @ObservedObject static var green = IntAndString(number: 153)
    @ObservedObject static var blue = IntAndString(number: 102)

    static var previews: some View {
        RGBelements(
            redElement: red,
            greenElement: green,
            blueElement: blue,
            font: .body,
            height: 300,
            width: 100
        )
    }
}
#endif
