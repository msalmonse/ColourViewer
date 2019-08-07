//
//  ColourEditor.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// ColourEditor displays 3 views, the current vales for RGB, HSB and the associated Colour
/// There are two structs with the same purpose, one for portrait and the other for landscape
///
/// Parameters
///     rgb:            main model of colour data
///     history:       a list of interesting colours
///     newLabel:   used to change displayed colour

struct PortraitColourEditor: View {
    @Binding var rgb: RGBandHSB
    @ObservedObject var history: ColourItemList
    @ObservedObject var newLabel: ObservableString
    
    var body: some View {
        GeometryReader { gp in
            NavigationView {
                ScrollView {
                    VStack(alignment: HorizontalAlignment.center) {
                        RGBsection(
                            rgb: self.$rgb,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        
                        HSBsection(
                            rgb: self.$rgb,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        
                        ColourSection(
                            rgb: self.$rgb,
                            history: self.history,
                            newLabel: self.newLabel,
                            height: gp.relativeHeight(0.3),
                            width: gp.relativeWidth(0.9)
                        )
                        
                        Spacer()
                    }
                }
                .navigationBarItems(
                    leading: Image(systemName: "square.and.pencil")
                        .font(Font.title.weight(.bold))
                        .foregroundColor(Color.primary)
                )
            }
        }
    }
}

struct LandscapeColourEditor: View {
    @Binding var rgb: RGBandHSB
    @ObservedObject var history: ColourItemList
    @ObservedObject var newLabel: ObservableString
    
    var body: some View {
        GeometryReader { gp in
            NavigationView {
                ScrollView([.horizontal, .vertical]) {
                    HStack(alignment: VerticalAlignment.top) {
                        Spacer()
                        
                        RGBsection(
                            rgb: self.$rgb,
                            height: gp.relativeHeight(0.9),
                            width: gp.relativeWidth(0.3)
                        )
                        
                        HSBsection(
                            rgb: self.$rgb,
                            height: gp.relativeHeight(0.9),
                            width: gp.relativeWidth(0.3)
                        )
                        
                        ColourSection(
                            rgb: self.$rgb,
                            history: self.history,
                            newLabel: self.newLabel,
                            height: gp.relativeHeight(0.9),
                            width: gp.relativeWidth(0.4)
                        )
                    }
                }
                .navigationBarItems(
                    leading: Image(systemName: "square.and.pencil")
                        .font(Font.title.weight(.bold))
                        .foregroundColor(Color.primary)
                )
            }
        }
    }
}

private struct RGBsection: View {
    @Binding var rgb: RGBandHSB
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        RGBelements(
            redElement: self.rgb.red,
            greenElement: self.rgb.green,
            blueElement: self.rgb.blue,
            font: .body,
            height: height,
            width: width
        )
    }
}

private struct HSBsection: View {
    @Binding var rgb: RGBandHSB
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        HSBelements(
            hueElement: self.rgb.hue,
            saturationElement: self.rgb.saturation,
            brightnessElement: self.rgb.brightness,
            font: .body,
            height: height,
            width: width
        )
    }
}

private struct ColourSection: View {
    @Binding var rgb: RGBandHSB
    @ObservedObject var history: ColourItemList
    @ObservedObject var newLabel: ObservableString
    let height: CGFloat
    let width: CGFloat
    
    var body: some View {
        ColourElements(
            colourItem: self.rgb.colourItem,
            history: self.history,
            newLabel: self.newLabel,
            font: .body,
            height: height,
            width: width
        )
        .onReceive(self.newLabel.publisher,
            perform: { self.rgb.label = $0 }
        )
    }
}


#if DEBUG
struct ColourEditor_Previews: PreviewProvider {
    @State static var rgb = RGBandHSB.random
    @ObservedObject static var history = ColourItemList([
        ColourItem(red:   0, green:   0, blue:   0, label: "black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "white")
    ])
    @ObservedObject static var newLabel = ObservableString("")

    static var previews: some View {
        PortraitColourEditor(
            rgb: $rgb,
            history: history,
            newLabel: newLabel
        )
    }
}
#endif
