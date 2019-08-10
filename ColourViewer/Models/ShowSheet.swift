//
//  ShowSheet.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-09.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// Enum to determine which sheet to show

enum ShowSheet {
    case none
    // Display Alert with error when saving file
    case saveFileError(Message)
    // Display search sheet
    case search
}

typealias PublishedShowSheet = Published<ShowSheet>
