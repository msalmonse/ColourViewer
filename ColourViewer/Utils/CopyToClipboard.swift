//
//  CopyToClipboard.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-24.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI

func copyToClipboard(_ item: ColourItem) {
    UIPasteboard.general.string = item.label
    UIPasteboard.general.color = item.uiColor
}
