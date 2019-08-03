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
///     rgb:            main model of colour data
///     history:       a list of interesting colours
///     newLabel:   used to change displayed colour

struct ColourEditor: View {
    @Binding var rgb: RGBandHSB
    @Binding var history: [ColourItem]
    @ObservedObject var newLabel: ObservableString
    
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
                            newLabel: self.newLabel,
                            font: .body,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        .onReceive(self.newLabel.publisher,
                            perform: { self.rgb.label = $0 }
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
    @State static var rgb = RGBandHSB.random
    @State static var history: [ColourItem] = [
        ColourItem(red:   0, green:   0, blue:   0, label: "black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "white")
    ]
    @ObservedObject static var newLabel = ObservableString("")

    static var previews: some View {
        ColourEditor(
            rgb: $rgb,
            history: $history,
            newLabel: newLabel
        )
    }
}
#endif
