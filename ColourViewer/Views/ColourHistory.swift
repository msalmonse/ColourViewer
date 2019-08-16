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
/// Environment
///     history:       a list of interesting colours

struct ColourHistory : View {
    @EnvironmentObject var history: ColourItemList
    
    var body: some View {
        GeometryReader { gp in
            VStack {
                HStack {
                    Image(systemName: "rectangle.stack")
                    .font(Font.title.weight(.bold))
                    .foregroundColor(.primary)
                    Spacer()
                    EditButton()
                }
                .padding(.vertical, 10)

                VStack(alignment: HorizontalAlignment.center) {
                    ColourHistoryAdmin()

                    List {
                        ForEach(self.history.list) { historyItem in
                            Button(
                                action: { newLabel.value = historyItem.label },
                                label: { HistoryRow(item: historyItem) }
                            )
                        }
                        .onDelete(perform: self.delete)
                        .onMove(perform: self.move)
                    }
                    .frame(
                        width: gp.relativeWidth(1.0),
                        height: gp.relativeHeight(0.9)
                    )
                }
            }
        }
    }
    
    /// Delete selected items from list
    private func delete(at: IndexSet) {
        for i in at.sorted().reversed() {
            history.list.remove(at: i)
        }
    }
    
    /// Move selected items in list
    private func move(from: IndexSet, to: Int) {
        for i in from.sorted().reversed() {
            let j = (to > i) ? to - 1 : to
            let ci = history.list.remove(at: i)
            history.list.insert(ci, at: j)
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
    @ObservedObject static var history = ColourItemList([
        ColourItem(red:   0, green:   0, blue:   0, label: "Black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "White")
    ])

    static var previews: some View {
        ColourHistory().environmentObject(history)
    }
}
#endif
