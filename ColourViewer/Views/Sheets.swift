//
//  Sheets.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct Sheets: View {
    @State var showSearch = false
    @ObservedObject var newLabel: ObservableString
    @State var saveErrorMessage: Message? = nil

    var body: some View {
        Text("")
        .hidden()
        .sheet(
            isPresented: $showSearch,
            content: { ColourSearch(newLabel: self.newLabel) }
        )
        .alert(item: self.$saveErrorMessage) { msg in
            Alert(
                title: Text("Save error"),
                message: Text(msg.text),
                dismissButton: .default(Text("Dismiss"))
            )
        }
        .onReceive(showSheet.publisher, perform: {sheet in
                switch sheet {
                case .search: self.showSearch = true
                case .saveFileError(let msg): self.saveErrorMessage = msg
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
