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

struct ColourElements: View {
    @ObservedObject var colourItem: ObservableColourItem
    @Binding var history: [ColourItem]
    @ObservedObject var showingSearch = ObservableBool(false)

    var body: some View {
        VStack {
            Section(header: Text("Colour").font(.subheadline)) {
                /// Colour name in black on a white background surrounded by the colour itself
                Text(colourItem.label)
                    .font(.system(.body, design: .monospaced))
                    .lineLimit(1)
                    .padding(5)
                    .foregroundColor(.black)
                    .background(filledRoundedRectangle(cornerRadius: 5, color: .white))
                    .frame(width: 128, height: 100, alignment: .center)
                    .overlay(strokedRoundedRectangle(cornerRadius: 10, stroke: 3))
                    .background(filledRoundedRectangle(cornerRadius: 10,
                        color: colourItem.color))
                    .padding(.bottom, 5)
                HStack {
                    /// Button to add current colour to history list
                    Button(
                        action: { self.history.insert(self.colourItem.unbind, at: 0) },
                        label: {
                            Image(systemName: "rectangle.stack.badge.plus")
                            .foregroundColor(.primary)
                        }
                    )
                    .modifier(buttonBackground())
                    /// Button to add colour and label to pasteboard
                     Button(
                        action: { copyToClipboard(self.colourItem.unbind) },
                        label: {
                            Image(systemName: "doc.on.clipboard")
                                .foregroundColor(.primary)
                            }
                    )
                    .modifier(buttonBackground())
                    /// Button to display the colour search view
                    Button(
                        action: { self.showingSearch.bool = true },
                        label: {
                            Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                        }
                    )
                    .modifier(buttonBackground())
                    .sheet(
                        isPresented: $showingSearch.bool,
                        content: {
                            ColourSearch(
                                showingSearch: self.showingSearch,
                                colourItem: self.colourItem
                            )
                        }
                    )
                }
            }
        }
        .padding(.leading, 5)
        .modifier(sectionBackground())
    }
}

#if DEBUG
struct ColourElements_Previews: PreviewProvider {
    @ObservedObject static var colourItem = ObservableColourItem(label: "RebeccaPurple")
    @State static var history: [ColourItem] = [
        ColourItem(red:   0, green:   0, blue:   0, label: "black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "white")
    ]
    static var previews: some View {
        ColourElements(colourItem: colourItem, history: $history)
    }
}
#endif
