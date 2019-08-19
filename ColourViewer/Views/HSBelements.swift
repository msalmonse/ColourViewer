//
//  HSBelements.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// Display and edit the hue, saturation and brightness components
///
/// Parameters:
///     hueElement:             element for hue
///     saturationElement:  element for saturation
///     brightnessElement:  element for brightness
///     font:           the main font size to use
///     height:                      desired height of view
///     width:                       derired width of view

struct HSBelements: View {
    @ObservedObject var hueElement: DoubleAndString
    @ObservedObject var saturationElement: DoubleAndString
    @ObservedObject var brightnessElement: DoubleAndString
    var font: Font
    var size: CGSize

    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            Section(header: Text("HSB").font(largerFont(font))) {
                DoubleElement(
                    label: "Hue°",
                    element: hueElement,
                    font: font,
                    size: size.relativeSize(1.0, 0.25)
                )

                DoubleElement(
                    label: "Saturation%",
                    element: saturationElement,
                    font: font,
                    size: size.relativeSize(1.0, 0.25)
                )

                DoubleElement(
                    label: "Brightness%",
                    element: brightnessElement,
                    font: font,
                    size: size.relativeSize(1.0, 0.25)
                )
            }
        }
        .modifier(sectionBackground())
    }
}

#if DEBUG
struct HSBelements_Previews: PreviewProvider {
    @ObservedObject static var hue = DegreesAndString(degrees: 0.0)
    @ObservedObject static var saturation = PerCentAndString(percent: 50.0)
    @ObservedObject static var brightness = PerCentAndString(percent: 50.0)

    static var previews: some View {
        HSBelements(
            hueElement: hue,
            saturationElement: saturation,
            brightnessElement: brightness,
            font: .body,
            size: CGSize(width: 100, height: 300)

        )
    }
}
#endif
