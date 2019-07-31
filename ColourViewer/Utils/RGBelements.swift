//
//  RGBelements.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct RGBelements: View {
    private func setRadices(base: Int) {
        let radix = Radix.radix(for: base)

        redElement.setRadix(radix: radix)
        greenElement.setRadix(radix: radix)
        blueElement.setRadix(radix: radix)
    }
    
    @ObservedObject var redElement: IntAndString
    @ObservedObject var greenElement: IntAndString
    @ObservedObject var blueElement: IntAndString
    
    @ObservedObject var base = ObservableInt(10)

    var body: some View {
        VStack {
            Section(header: Text("RGB").font(.subheadline)) {
                IntElement(
                    label: "Red",
                    element: redElement
                )
                IntElement(
                    label: "Green",
                    element: greenElement
                )
                IntElement(
                    label: "Blue",
                    element: blueElement
                )
                Picker("Radix", selection: $base.number) {
                    Text("Dec").tag(10)
                    Text("Hex").tag(16)
                    Text("Oct").tag(8)
                }
                .pickerStyle(SegmentedPickerStyle())
                .font(.caption)
                .frame(width: 30)
                .onReceive(base.publisher, perform: { self.setRadices(base: $0) })
            }
        }
        .modifier(sectionBackground())
        
    }
}

#if DEBUG
struct RGBelements_Previews: PreviewProvider {
    @ObservedObject static var red = IntAndString(number: 51)
    @ObservedObject static var green = IntAndString(number: 153)
    @ObservedObject static var blue = IntAndString(number: 102)

    static var previews: some View {
        RGBelements( redElement: red, greenElement: green, blueElement: blue )
    }
}
#endif
