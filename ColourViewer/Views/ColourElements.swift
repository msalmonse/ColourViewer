//
//  ColourElements.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// ColourElements displays the name or hex code of the current colour surrounded by the actual colour
/// There are 3 buttons that change this colour in various ways
///
/// Parameters:
///     colourItem:     the colour to display
///     font:                the main font size to use
///     size:                the height and width to use
/// Environment
///     history:           a list of interesting colours
/// Global
///     showSheet:    used to open alerts et al.

struct ColourElements: View {
    @ObservedObject var colourItem: ObservableColourItem
    @EnvironmentObject var history: ColourItemList
    let font: Font
    let size: CGSize

    var body: some View {
        VStack(alignment: HorizontalAlignment.center) {
            Section(header: Text("Colour").font(largerFont(font))) {
                // Colour name in black on a white background surrounded by the colour itself
                Text(colourItem.label)
                    .font(.system(textStyle(smallerFont(font)), design: .monospaced))
                    .lineLimit(1)
                    .padding(3)
                    .foregroundColor(.black)
                    .background(filledRoundedRectangle(cornerRadius: 3, color: .white))
                    .frame(
                        width: size.relativeWidth(0.8),
                        height: size.relativeHeight(0.35),
                        alignment: .center
                    )
                    .overlay(strokedRoundedRectangle(cornerRadius: 10, stroke: 3))
                    .background(filledRoundedRectangle(cornerRadius: 10,
                        color: colourItem.color))
                    .padding(.bottom, 5)
                HStack {
                    // Button to add current colour to history list
                    Button(
                        action: {
                            self.history.list.insert(self.colourItem.unwrap, at: 0)
                        },
                        label: {
                            Image(systemName: "rectangle.stack.badge.plus")
                            .foregroundColor(.primary)
                        }
                    )
                    .modifier(buttonBackground())
                    // Button to add colour and label to pasteboard
                     Button(
                        action: { copyToClipboard(self.colourItem.unwrap) },
                        label: {
                            Image(systemName: "doc.on.clipboard")
                            .foregroundColor(.primary)
                        }
                    )
                    .modifier(buttonBackground())
                    // Button to display the colour search view
                    Button(
                        action: { showSheet.value = .search },
                        label: {
                            Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                        }
                    )
                    .modifier(buttonBackground())
                }
            }
        }
        .modifier(sectionBackground())
    }
}

#if DEBUG
struct ColourElements_Previews: PreviewProvider {
    @ObservedObject static var colourItem = ObservableColourItem(label: "RebeccaPurple")
    @State static var history = ColourItemList([
        ColourItem(red:   0, green:   0, blue:   0, label: "black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "white")
    ])
    
    static var previews: some View {
        ColourElements(
            colourItem: colourItem,
            font: .body,
            size: CGSize(width: 200, height: 300)
        )
        .environmentObject(history)
    }
}
#endif
