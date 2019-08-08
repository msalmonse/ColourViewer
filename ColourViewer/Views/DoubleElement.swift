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
///     font:           the main font size to use
///     height:       desired height of view
///     width:        derired width of view


struct DoubleElement : View {
    let label: String
    @ObservedObject var element: DoubleAndString
    var font: Font
    var size: CGSize

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading, spacing: 3) {
            Text(label).font(smallerFont(font, by: 2))
            HStack {
                // Increment button
                Button(
                    action: { self.element.number += 0.1 },
                    label: {
                        Image(systemName: "plus.square")
                        .font(font.weight(.semibold))
                        .foregroundColor(.primary)
                    }
                )
                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal, 5)
                .frame(width: size.relativeWidth(0.5))
                .font(.system(textStyle(font), design: .monospaced))
                .overlay(strokedRoundedRectangle(cornerRadius: 3))

                // Decrement button
                Button(
                    action: { self.element.number -= 0.1 },
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
struct DoubleElement_Previews : PreviewProvider {
    static var test = DoubleAndString(number: 100.0, min: 0, max: 255)

    static var previews: some View {
        DoubleElement (
            label: "Test",
            element: test,
            font: .body,
            size: CGSize(width: 45, height: 100)
        )
    }
}
#endif
