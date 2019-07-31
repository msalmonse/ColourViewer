//
//  Modifiers.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct sectionBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 12)
            .overlay(strokedRoundedRectangle(cornerRadius: 5, stroke: 2))
    }
}

struct buttonBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(12)
            .overlay(strokedRoundedRectangle(cornerRadius: 5, stroke: 2))
    }
}
