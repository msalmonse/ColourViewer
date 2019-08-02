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
///     width:        derired width of view


struct DoubleElement : View {
    let label: String
    @ObservedObject var element: DoubleAndString
    var width: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.caption)
            HStack {
                /// Increment button
                Button(
                    action: { self.element.number += 0.1 },
                    label: { Image(systemName: "plus.circle").accentColor(.secondary) }
                )
                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .frame(width: 75)
                .font(.system(.body, design: .monospaced))
                
                Button(
                    action: { self.element.number -= 0.1 },
                    label: { Image(systemName: "minus.circle").accentColor(.secondary) }
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
            width: 100
        )
    }
}
#endif
