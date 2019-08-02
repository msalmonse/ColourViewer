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
        GeometryReader { gp in
            NavigationView {
                ScrollView {
                    VStack(alignment: HorizontalAlignment.center) {
                        RGBelements(
                            redElement: self.rgb.red,
                            greenElement: self.rgb.green,
                            blueElement: self.rgb.blue,
                            font: .body,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        
                        HSBelements(
                            hueElement: self.rgb.hue,
                            saturationElement: self.rgb.saturation,
                            brightnessElement: self.rgb.brightness,
                            font: .body,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        
                        ColourElements(
                            colourItem: self.rgb.colourItem,
                            history: self.$history,
                            font: .body,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        
                        Spacer()
                    }
                }
                .navigationBarItems(
                    leading: Image(systemName: "square.and.pencil")
                        .font(Font.title.weight(.bold))
                        .accentColor(Color.primary)
                )
            }
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
        ColourEditor(
            history: $history
        )
    }
}
#endif
