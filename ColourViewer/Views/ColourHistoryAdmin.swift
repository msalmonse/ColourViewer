//
//  ColourHistoryAdmin.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// ColourHistory Buttons
///
/// Global
///     showSheet:    used to open alerts et al.

struct ColourHistoryAdmin: View {
    @EnvironmentObject var history: ColourItemList

    var body: some View {
        HStack {
            Button(
                action: {
                    switch self.history.save() {
                    case .success(): break
                    case .failure(let err):
                        showSheet.value = .showAlert(errorMessage(err, .fileSave))
                    }
                },
                label: {
                    Text("\u{1F4BE}")
                    .foregroundColor((self.history.changeCount == 0) ? .secondary : .primary)
                }
            )
            .disabled(self.history.isEmpty)
            Spacer()
            Button(
                action: { showSheet.value = .removeSaveFile },
                label: {
                    ZStack {
                        Text("\u{1F4BE}")
                        .foregroundColor(.primary)
                        Image(systemName: "x.circle")
                        .foregroundColor(.red)
                        .font(Font.largeTitle.weight(.bold))
                    }
                }
            )
            Spacer()
            Button(
                action: { self.history.list.removeAll() },
                label: {
                    Image(systemName: "clear")
                    .foregroundColor((self.history.isEmpty) ? .secondary : .red)
                    .font(Font.title.weight(.bold))
                }
            )
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
    }
}

#if DEBUG
struct ColourHistoryAdmin_Previews: PreviewProvider {
    @ObservedObject static var history = ColourItemList([
        ColourItem(red:   0, green:   0, blue:   0, label: "Black"),
        ColourItem(red: 255, green: 255, blue: 255, label: "White")
    ])

    static var previews: some View {
        ColourHistoryAdmin().environmentObject(history)
    }
}
#endif
