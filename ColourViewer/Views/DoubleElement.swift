//
//  DoubleElement.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// A View to display and edit a Double value
///
/// Parameters:
///     label:          label for element
///     element:    the Double value and it's associated String
///     height:       desired height of view
///     width:        derired width of view


struct DoubleElement : View {
    let label: String
    @ObservedObject var element: DoubleAndString
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(label + ": \(height)x\(width)").font(.caption)
            HStack {
                /// Increment button
                Button(
                    action: { self.element.number += 0.1 },
                    label: { Image(systemName: "plus.circle").accentColor(.primary) }
                )
                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .frame(width: 75)
                .font(.system((height < 50) ? .callout : .body, design: .monospaced))
                
                Button(
                    action: { self.element.number -= 0.1 },
                    label: { Image(systemName: "minus.circle").accentColor(.primary) }
                )
            }
            .overlay(strokedRoundedRectangle(cornerRadius: 3))
        }
    }
}

#if DEBUG
struct DoubleElement_Previews : PreviewProvider {
    static var test = DoubleAndString(number: 100.0, min: 0, max: 255)

    static var previews: some View {
        DoubleElement (
            label: "Test",
            element: test,
            height: 300,
            width: 100
        )
    }
}
#endif
