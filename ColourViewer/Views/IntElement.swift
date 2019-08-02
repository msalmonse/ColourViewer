//
//  IntElement.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// View to display and edit a single int element
///
/// Parameters:
///     label:         label for the element to display and edit
///     element:    Int value and associated string
///     height:       desired height of view
///     width:        derired width of view

struct IntElement : View {
    let label: String
    @ObservedObject var element: IntAndString
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(label + ": \(height)x\(width)").font(.caption)
            HStack {
                /// Increment button
                Button(
                    action: { self.element.number += 1 },
                    label: { Image(systemName: "plus.circle").accentColor(.primary) }
                )
                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .frame(width: 75)
                    .font(.system((height < 40) ? .callout : .body, design: .monospaced))
                /// Decrement button
                Button(
                    action: { self.element.number -= 1 },
                    label: { Image(systemName: "minus.circle").accentColor(.primary) }
                )
            }
            .overlay(strokedRoundedRectangle(cornerRadius: 3))
        }
    }
}

#if DEBUG
struct IntElement_Previews : PreviewProvider {
    static var test = IntAndString(number: 100, min: 0, max: 255)
    static var previews: some View {
        IntElement (
            label: "Test",
            element: test,
            height: 45,
            width: 100
        )
    }
}
#endif

