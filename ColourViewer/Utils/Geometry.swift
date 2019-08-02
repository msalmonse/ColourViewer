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
    func relativeWidth(_ factor: CGFloat) -> CGFloat {
        return self.size.width * factor
    }

    /// Calculate the relative height
    func relativeHeight(_ factor: CGFloat) -> CGFloat {
        return self.size.height * factor
    }
}
