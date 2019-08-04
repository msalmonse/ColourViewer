//
//  ContentView.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State var history: [ColourItem] = [
//        ColourItem(red: 255, green:   0, blue:   0, label: "Red"),
//        ColourItem(red: 255, green: 255, blue:   0, label: "Yellow"),
//        ColourItem(red:   0, green: 255, blue:   0, label: "Green")
    ]
    @ObservedObject var newLabel = ObservableString("")
    @State var rgb = RGBandHSB.random
    
    var body: some View {
        GeometryReader() { gp in
            HStack(alignment: VerticalAlignment.top, spacing: 5) {
                if gp.isLandscape {
                    LandscapeColourEditor(
                        rgb: self.$rgb,
                        history: self.$history,
                        newLabel: self.newLabel
                    )
                    .frame(width: gp.relativeWidth(0.7))
                }
                else {
                    PortraitColourEditor(
                        rgb: self.$rgb,
                        history: self.$history,
                        newLabel: self.newLabel
                    )
                }
                
                Divider().frame(width: 1)
                
                ColourHistory(
                    history: self.$history,
                    newLabel: self.newLabel
                )
            }
        }
        .environment(\.horizontalSizeClass, .compact)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
