//
//  Shapes.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

func strokedRoundedRectangle(
        cornerRadius r: CGFloat,
        stroke w: CGFloat = 1,
        color c: Color = .primary
    ) -> some View {
    
    return RoundedRectangle(cornerRadius: r).stroke(lineWidth: w).foregroundColor(c)
}

func filledRoundedRectangle(
        cornerRadius r: CGFloat,
        color c: Color = .primary
    ) -> some View {
    
    return RoundedRectangle(cornerRadius: r).foregroundColor(c)
}
