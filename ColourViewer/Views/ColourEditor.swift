//
//  ColourEditor.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// ColourEditor displays 3 views, the current vales for RGB, HSB and the associated Colour
///
/// Parameters
///     history:    a list of interesting colours

struct ColourEditor: View {
    @Binding var history: [ColourItem]
    
    var rgb = RGBandHSB.random
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                RGBelements(
                    redElement: rgb.red,
                    greenElement: rgb.green,
                    blueElement: rgb.blue
                )
                
                HSBelements(
                    hueElement: rgb.hue,
                    saturationElement: rgb.saturation,
                    brightnessElement: rgb.brightness
                )
                
                ColourElements(
                    colourItem: rgb.colourItem,
                    history: $history
                )
                
                Spacer()
            }
            .navigationBarItems(
                leading: Image(systemName: "square.and.pencil")
                    .font(Font.title.weight(.bold))
                    .accentColor(Color.primary)
            )
        }
    }
}

#if DEBUG
struct ColourEditor_Previews: PreviewProvider {
    @State static var history: [ColourItem] = [
        ColourItem(red:   0, green:   0, blue:   0, label: "black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "white")
    ]

    static var previews: some View {
        ColourEditor(history: $history)
    }
}
#endif
