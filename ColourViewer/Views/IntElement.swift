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
    var height: CGFloat
    var width: CGFloat

    var body: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            Text(label).font(smallerFont(font, by: 2))

            HStack {
                /// Increment button
                Button(
                    action: { self.element.number += 1 },
                    label: {
                        Image(systemName: "plus.square.fill")
                        .accentColor(.primary)
                    }
                )

                /// Edittor for the String value
                TextField("value", text: $element.string)
                .multilineTextAlignment(.trailing)
                .font(.system(textStyle(smallerFont(font)), design: .monospaced))
                .frame(width: width * 0.4)
                .overlay(strokedRoundedRectangle(cornerRadius: 3))

                /// Decrement button
                Button(
                    action: { self.element.number -= 1 },
                    label: {
                        Image(systemName: "minus.square.fill")
                        .accentColor(.primary)
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
            height: 45,
            width: 100
        )
    }
}
#endif

