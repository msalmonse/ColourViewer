//
//  DoubleElement.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct DoubleElement : View {
    let label: String
    @ObservedObject var element: DoubleAndString
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label).font(.caption)
            HStack {
                Button(
                    action: { self.element.number += 0.1 },
                    label: { Image(systemName: "plus.circle").accentColor(.secondary) }
                )
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
            element: test
        )
    }
}
#endif
