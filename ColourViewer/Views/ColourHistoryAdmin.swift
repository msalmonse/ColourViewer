//
//  ColourHistoryAdmin.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ColourHistoryAdmin: View {
    @ObservedObject var history: ColourItemList
    @State var saveErrorMessage: Message? = nil

    var body: some View {
        HStack {
            Button(
                action: {
                    switch self.history.save() {
                    case .success(): break
                    case .failure(let error): self.saveErrorMessage = errorMessage(error)
                    }
                },
                label: {
                    Text("\u{1F4BE}")
                    .foregroundColor((self.history.changeCount == 0) ? .secondary : .primary)
                }
            )
            .alert(item: self.$saveErrorMessage) { msg in
                Alert(
                    title: Text("Save error"),
                    message: Text(msg.text),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
            Spacer()
            Button(
                action: { self.history.list.removeAll() },
                label: {
                    Image(systemName: "clear")
                    .foregroundColor((self.history.isEmpty) ? .secondary : .primary)
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
        ColourHistoryAdmin(history: history)
    }
}
#endif
