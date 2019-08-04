//
//  Geometry.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-02.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI

extension GeometryProxy {
    /// Calculate the relative width
    func relativeWidth(_ factor: Double) -> CGFloat {
        return self.size.relativeWidth(factor)
    }

    /// Calculate the relative height
    func relativeHeight(_ factor: Double) -> CGFloat {
        return self.size.relativeHeight(factor)
    }
    
    /// Is the display in landscape
    var isLandscape: Bool { return self.size.width > self.size.height }
}

extension CGSize {
    /// Calculate the relative width
    func relativeWidth(_ factor: Double) -> CGFloat {
        return self.width * CGFloat(factor)
    }

    /// Calculate the relative height
    func relativeHeight(_ factor: Double) -> CGFloat {
        return self.height * CGFloat(factor)
    }
}
