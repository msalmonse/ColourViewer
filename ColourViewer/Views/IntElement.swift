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
///     font:           the main font size to use
///     height:       desired height of view
///     width:        derired width of view

struct IntElement : View {
    let label: String
    @ObservedObject var element: IntAndString
    var font: Font
    var size: CGSize

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 3) {
            Text(label).font(smallerFont(font, by: 2))

            HStack {
                /// Increment button
                Button(
                    action: { self.element.number += 1 },
                    label: {
                        Image(systemName: "plus.square")
                        .font(font.weight(.semibold))
                        .foregroundColor(.primary)
                    }
                )

                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .font(.system(textStyle(font), design: .monospaced))
                .padding(.horizontal, 5)
                .frame(width: size.relativeWidth(0.5))
                .overlay(strokedRoundedRectangle(cornerRadius: 3))

                /// Decrement button
                Button(
                    action: { self.element.number -= 1 },
                    label: {
                        Image(systemName: "minus.square")
                        .font(font.weight(.semibold))
                        .foregroundColor(.primary)
                    }
                )
            }
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
            font: .body,
            size: CGSize(width: 100, height: 45)
        )
    }
}
#endif
