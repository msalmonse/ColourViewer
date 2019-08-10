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
    @State var title = ""
    @State var fileErrorMessage: Message? = nil
    @EnvironmentObject var history: ColourItemList

    var body: some View {
        Text("")
        .hidden()
        // Remove save file
        .actionSheet(isPresented: $showRemove) {
            ActionSheet(
                title: Text("Remove file?").font(.title),
                buttons: [
                    .cancel(),
                    .destructive(Text("OK"),
                        action: {
                            switch self.history.removeSaved() {
                            case .success(): break
                            case .failure(let err):
                                showSheet.value = .fileError("Remove save file", errorMessage(err))
                            }
                        }
                    )
                ]
            )
        }
        // Error while handling file
        .alert(item: self.$fileErrorMessage) { msg in
            Alert(
                title: Text(self.title),
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
                case .fileError(let title, let msg):
                    self.title = title
                    self.fileErrorMessage = msg
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
