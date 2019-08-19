//
//  ContentView.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

var showSheet = PublishedShowSheet(.none)
var newLabel = PublishedString("")

struct ContentView : View {
    @ObservedObject var history = ColourItemList.load()
    @State var rgb = RGBandHSB.random

    var body: some View {
        GeometryReader { gp in
            HStack(alignment: VerticalAlignment.top, spacing: 5) {
                if gp.isLandscape {
                    LandscapeColourEditor(
                        rgb: self.$rgb
                    )
                    .frame(width: gp.relativeWidth(0.7))
                } else {
                    PortraitColourEditor(
                        rgb: self.$rgb
                    )
                }

                Divider().frame(width: 1)

                ColourHistory()

                // Empty view to hold displayed sheets
                Sheets()
            }
        }
        .environment(\.horizontalSizeClass, .compact)
        .environmentObject(history)
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
