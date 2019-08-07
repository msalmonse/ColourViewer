//
//  ColourSearchShow.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-07.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct ColourSearchShow: View {
    @State var show = false
    @ObservedObject var newLabel: ObservableString

    var body: some View {
        Button(
            action: { self.show = true },
            label: {
                Image(systemName: "magnifyingglass")
                .foregroundColor(.primary)
            }
        )
        .disabled(show)
        .modifier(buttonBackground())
        .sheet(
            isPresented: $show,
            content: { ColourSearch(newLabel: self.newLabel) }
        )
    }
}

#if DEBUG
struct ColourSearchShow_Previews: PreviewProvider {
    @ObservedObject static var newLabel = ObservableString("")
    static var previews: some View {
        ColourSearchShow(newLabel: newLabel)
    }
}
#endif
