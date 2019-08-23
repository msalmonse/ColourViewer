//
//  Sheets.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

/// Central place for displaying alerts et al.
///
/// Global
///     showSheet:    used to open alerts et al.

struct Sheets: View {
    @State var showRemove = false
    @State var showSearch = false
    @State var showSettings = false
    @State var alertMessage: Message? = nil
    @EnvironmentObject var history: ColourItemList

    var body: some View {
        ZStack {
            Text("").hidden()
            // Remove save file
            .actionSheet(isPresented: $showRemove) {
                ActionSheet(
                    title: Text("Remove file?"),
                    buttons: [
                        .cancel(),
                        .destructive(Text("OK"),
                            action: {
                                switch self.history.removeSaved() {
                                case .success:
                                    showSheet.value = .showAlert(
                                        Message("History file removed", subject: "Remove history")
                                    )
                                case .failure(let err):
                                    showSheet.value = .showAlert(errorMessage(err, .removeFile))
                                }
                            }
                        )
                    ]
                )
            }

            Text("").hidden()
            // Error display
            .alert(item: self.$alertMessage) { msg in
                Alert(
                    title: Text(msg.subject ?? "Alert"),
                    message: Text(msg.text),
                    dismissButton: .default(Text("Dismiss"))
                )
            }

            Text("").hidden()
            // show colour search
            .sheet(
                isPresented: $showSearch,
                content: { ColourSearch() }
            )

            Text("").hidden()
            // show settings
            .sheet(
                isPresented: $showSettings,
                content: { Settings() }
            )

            Text("").hidden()
            .onReceive(showSheet.publisher, perform: {showIt in
                    switch showIt {
                    case .removeSaveFile: self.showRemove = true
                    case .search: self.showSearch = true
                    case .settings: self.showSettings = true
                    case .showAlert(let msg): self.alertMessage = msg
                    case .none: break
                    }
                }
            )
        }
    }
}

#if DEBUG
struct Sheets_Previews: PreviewProvider {
    static var previews: some View {
        Sheets()
    }
}
#endif
