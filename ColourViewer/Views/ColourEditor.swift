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
/// Environment
///     history:       a list of interesting colours
/// Global:
///     newLabel:   used to change colour

struct PortraitColourEditor: View {
    @Binding var rgb: RGBandHSB
    @EnvironmentObject var history: ColourItemList

    var body: some View {
        GeometryReader { gp in
            VStack {
                TopBar()
                ScrollView {
                    VStack(alignment: HorizontalAlignment.center, spacing: gp.relativeHeight(0.01)) {
                        RGBsection(
                            rgb: self.$rgb,
                            size: gp.relativeSize(0.9, 0.3)
                        )

                        HSBsection(
                            rgb: self.$rgb,
                            size: gp.relativeSize(0.9, 0.3)
                        )

                        UndoRedo(
                            font: .body,
                            size: gp.relativeSize(0.9, 0.1)
                        )

                        ColourSection(
                            rgb: self.$rgb,
                            size: gp.relativeSize(0.9, 0.3)
                        )

                        Spacer()
                    }
                }
            }
        }
    }
}

struct LandscapeColourEditor: View {
    @Binding var rgb: RGBandHSB
    @EnvironmentObject var history: ColourItemList

    var body: some View {
        GeometryReader { gp in
            VStack {
                TopBar()
                ScrollView([.horizontal, .vertical]) {
                    HStack(alignment: VerticalAlignment.top, spacing: 1) {
                        RGBsection(
                            rgb: self.$rgb,
                            size: gp.relativeSize(0.3, 0.9)
                        )
                        .padding(.leading, 2)

                        VStack {
                            HSBsection(
                                rgb: self.$rgb,
                                size: gp.relativeSize(0.3, 0.9)
                            )

                            UndoRedo(
                                font: .body,
                                size: gp.relativeSize(0.1, 0.9)
                            )
                        }

                        ColourSection(
                            rgb: self.$rgb,
                            size: gp.relativeSize(0.4, 0.9)
                        )
                    }
                }
            }
        }
    }
}

private struct TopBar: View {
    var body: some View {
        HStack {
            Image(systemName: "square.and.pencil")
            .font(Font.title.weight(.bold))
            .foregroundColor(Color.primary)
            Spacer()
            Button(
                action: { showSheet.value = .settings },
                label: {
                    Image(systemName: "gear")
                    .font(Font.title.weight(.bold))
                    .foregroundColor(Color.primary)
                }
            )
        }
        .padding(10)
    }
}

private struct RGBsection: View {
    @Binding var rgb: RGBandHSB
    let size: CGSize

    var body: some View {
        RGBelements(
            redElement: self.rgb.red,
            greenElement: self.rgb.green,
            blueElement: self.rgb.blue,
            font: .body,
            size: size
        )
    }
}

private struct HSBsection: View {
    @Binding var rgb: RGBandHSB
    let size: CGSize

    var body: some View {
        HSBelements(
            hueElement: self.rgb.hue,
            saturationElement: self.rgb.saturation,
            brightnessElement: self.rgb.brightness,
            font: .body,
            size: size
        )
    }
}

private struct ColourSection: View {
    @Binding var rgb: RGBandHSB
    @EnvironmentObject var history: ColourItemList
    let size: CGSize

    var body: some View {
        ColourElements(
            colourItem: self.rgb.colourItem,
            font: .body,
            size: size
        )
        .onReceive(newLabel.publisher, perform: { self.rgb.label = $0 })
    }
}

#if DEBUG
struct ColourEditor_Previews: PreviewProvider {
    @State static var rgb = RGBandHSB.random
    @ObservedObject static var history = ColourItemList([
        ColourItem(red:   0, green:   0, blue:   0, label: "black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "white")
    ])

    static var previews: some View {
        PortraitColourEditor(
            rgb: $rgb
        )
        .environmentObject(history)
    }
}
#endif
