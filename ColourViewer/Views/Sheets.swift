//
//  Sheets.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct Sheets: View {
    @State var showRemove = false
    @State var showSearch = false
    @ObservedObject var newLabel: ObservableString
    @State var alertMessage: Message? = nil
    @EnvironmentObject var history: ColourItemList

    var body: some View {
        Text("")
        .hidden()
        // Remove save file
        .actionSheet(isPresented: $showRemove) {
            ActionSheet(
                title: Text("Remove file?"),
                buttons: [
                    .cancel(),
                    .destructive(Text("OK"),
                        action: {
                            switch self.history.removeSaved() {
                            case .success(): break
                            case .failure(let err):
                                showSheet.value = .showAlert(errorMessage(err, .removeFile))
                            }
                        }
                    )
                ]
            )
        }
        // Error display
        .alert(item: self.$alertMessage) { msg in
            Alert(
                title: Text(msg.subject ?? "Alert"),
                message: Text(msg.text),
                dismissButton: .default(Text("Dismiss"))
            )
        }
        // show colour search
        .sheet(
            isPresented: $showSearch,
            content: { ColourSearch(newLabel: self.newLabel) }
        )
        .onReceive(showSheet.publisher, perform: {sheet in
                switch sheet {
                case .removeSaveFile: self.showRemove = true
                case .search: self.showSearch = true
                case .showAlert(let msg): self.alertMessage = msg
                case .none: break
                }
            }
        )
    }
}

#if DEBUG
struct Sheets_Previews: PreviewProvider {
    @ObservedObject static var newLabel = ObservableString("")

    static var previews: some View {
        Sheets(newLabel: self.newLabel)
    }
}
#endif
