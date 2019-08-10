//
//  ContentView.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

var showSheet = PublishedShowSheet(.none)

struct ContentView : View {
    @ObservedObject var history = ColourItemList.load()
    
    @ObservedObject var newLabel = ObservableString("")
    @State var rgb = RGBandHSB.random
    
    var body: some View {
        GeometryReader() { gp in
            HStack(alignment: VerticalAlignment.top, spacing: 5) {
                if gp.isLandscape {
                    LandscapeColourEditor(
                        rgb: self.$rgb,
                        newLabel: self.newLabel
                    )
                    .frame(width: gp.relativeWidth(0.7))
                }
                else {
                    PortraitColourEditor(
                        rgb: self.$rgb,
                        newLabel: self.newLabel
                    )
                }
                
                Divider().frame(width: 1)
                
                ColourHistory(
                    newLabel: self.newLabel
                )
                
                // Empty view to hold displayed sheets
                Sheets(newLabel: self.newLabel)
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
