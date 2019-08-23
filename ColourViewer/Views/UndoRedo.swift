//
//  UndoRedo.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-23.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct UndoRedo: View {
    let font: Font
    let size: CGSize

    var body: some View {
        VStack {
            Section(header: Text("Undo/Redo").font(largerFont(font))) {
                HStack {
                    Spacer()
                    Button(
                        action: { unMan.undo() },
                        label: { Image(systemName: "gobackward")}
                    )
                    .modifier(buttonBackground())
                    Spacer()
                    Button(
                        action: { unMan.redo() },
                        label: { Image(systemName: "goforward")}
                    )
                    .modifier(buttonBackground())
                    Spacer()
                }
                .frame(width: size.relativeWidth(0.8))
            }
        }
        .modifier(sectionBackground())
    }
}

struct UndoRedo_Previews: PreviewProvider {
    static var previews: some View {
        UndoRedo(font: .body, size: CGSize(width: 300, height: 300))
    }
}
