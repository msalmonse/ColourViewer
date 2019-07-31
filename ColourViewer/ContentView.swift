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
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .top, spacing: 10) {
                ColourEditor(
                    history: self.$history
                )
                
                Divider().frame(width: 1)
                
                ColourHistory(
                    history: self.$history
                )
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
