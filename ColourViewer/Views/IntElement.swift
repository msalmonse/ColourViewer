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
            Text(label).font(.caption)
            HStack {
                /// Increment button
                Button(
                    action: { self.element.number += 1 },
                    label: { Image(systemName: "plus.circle").accentColor(.secondary) }
                )
                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .frame(width: 75)
                .font(.system(.body, design: .monospaced))
                /// Decrement button
                Button(
                    action: { self.element.number -= 1 },
                    label: { Image(systemName: "minus.circle").accentColor(.secondary) }
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
            height: 300,
            width: 100
        )
    }
}
#endif

