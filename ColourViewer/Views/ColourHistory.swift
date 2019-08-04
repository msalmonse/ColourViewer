//
//  ColourHistory.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// Display a list of interesting colours
///
/// Parameters:
///     history:            a list of interesting colours
///     newLabel:       used to update displayed colour

struct ColourHistory : View {
    @Binding var history: [ColourItem]
    @ObservedObject var newLabel: ObservableString
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5) {
                HStack {
                    Button(
                        action: { print("save") },
                        label: {
                            Text("\u{1F4BE}")
                        }
                    )
                    Spacer()
                    Button(
                        action: { self.history = [] },
                        label: { Image(systemName: "clear")}
                    )
                }
                .padding(10)

                List {
                    ForEach(history) { historyItem in
                        Button(
                            action: { self.newLabel.string = historyItem.label },
                            label: { HistoryRow(item: historyItem) }
                        )
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
            .navigationBarItems(
                leading:
                    Image(systemName: "rectangle.stack")
                    .font(Font.title.weight(.bold))
                    .accentColor(.primary),
                trailing: EditButton()
            )
        }
    }
    
    /// Delete selected items from list
    private func delete(at: IndexSet) {
        for i in at.sorted().reversed() {
            history.remove(at: i)
        }
    }
    
    /// Move selected items in list
    private func move(from: IndexSet, to: Int) {
        for i in from.sorted().reversed() {
            let j = (to > i) ? to - 1 : to
            let ci = history.remove(at: i)
            history.insert(ci, at: j)
        }
    }
}

/// Display a single item in the history list

fileprivate struct HistoryRow: View {
    let item: ColourItem
    
    var body: some View {
        /// Display the colour name or hex code surrounded by the colour
        HStack {
            Spacer()
            Text(item.label)
                .padding(5)
                .font(.system(.caption, design: .monospaced))
                .lineLimit(1)
                .foregroundColor(.black)
                .background(filledRoundedRectangle(cornerRadius: 5, color: .white))
            Spacer()
        }
        .padding(5)
        .overlay(strokedRoundedRectangle(cornerRadius: 10, stroke: 3))
        .background(filledRoundedRectangle(cornerRadius: 10, color: item.color))
        .padding(.leading, 20)
    }
}

#if DEBUG
struct ColourHistory_Previews : PreviewProvider {
    @State static var history: [ColourItem] = [
        ColourItem(red:   0, green:   0, blue:   0, label: "Black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "White")
    ]
    @ObservedObject static var newLabel = ObservableString("")

    static var previews: some View {
        ColourHistory(
            history: $history,
            newLabel: newLabel
        )
    }
}
#endif
