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
                    case .success(let url):
                        let text = "History saved to " + url.lastPathComponent
                        showSheet.value = .showAlert(Message(text, subject: "Save to file"))
                    case .failure(let err):
                        showSheet.value = .showAlert(errorMessage(err, .fileSave))
                    }
                },
                label: {
                    Image(systemName: "square.and.arrow.up.on.square")
                    .font(Font.headline.weight(.bold))
                    .foregroundColor((self.history.noChanges) ? .secondary : .primary)
                }
            )
            .disabled(self.history.noChanges)

            Spacer()

            Button(
                action: {
                    switch self.history.reload() {
                    case .success(let url):
                        let text = "History reloaded from " + url.lastPathComponent
                        showSheet.value = .showAlert(Message(text, subject: "Reload from file"))
                    case .failure(let err):
                        showSheet.value = .showAlert(errorMessage(err, .fileReload))
                    }
                },
                label: {
                    Image(systemName: "square.and.arrow.down.on.square")
                    .font(Font.headline.weight(.bold))
                    .foregroundColor((self.history.noSaveURL) ? .secondary : .primary)
                }
            )
            .disabled(self.history.noSaveURL)

            Spacer()

            Button(
                action: { showSheet.value = .removeSaveFile },
                label: {
                    ZStack {
                        Image(systemName: "square.and.arrow.up.on.square")
                        .font(Font.headline.weight(.bold))
                        .foregroundColor(.primary)
                        Image(systemName: "x.circle")
                        .foregroundColor(.red)
                        .font(Font.largeTitle.weight(.bold))
                    }
                }
            )
            .disabled(self.history.noSaveURL)

            Spacer()

            Button(
                action: { self.history.list.removeAll() },
                label: {
                    Image(systemName: "clear")
                    .foregroundColor((self.history.isEmpty) ? .secondary : .red)
                    .font(Font.title.weight(.bold))
                }
            )
            .disabled(self.history.isEmpty)
        }
        .padding(.vertical, 5)
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
