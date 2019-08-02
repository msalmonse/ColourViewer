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
///     height:                      desired height of view
///     width:                       derired width of view

struct HSBelements: View {
    @ObservedObject var hueElement: DoubleAndString
    @ObservedObject var saturationElement: DoubleAndString
    @ObservedObject var brightnessElement: DoubleAndString
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        VStack {
            Section(header: Text("HSB" + ": \(height)x\(width)").font(.subheadline)) {
                DoubleElement(
                    label: "Hue",
                    element: hueElement,
                    height: height/4,
                    width: width
                )
                
                DoubleElement(
                    label: "Saturation",
                    element: saturationElement,
                    height: height/4,
                    width: width
                )
                
                DoubleElement(
                    label: "Brightness",
                    element: brightnessElement,
                    height: height/4,
                    width: width
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
            height: 300,
            width: 100
        )
    }
}
#endif
