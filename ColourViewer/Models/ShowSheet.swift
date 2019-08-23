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
    // Display action sheet to remove savefile
    case removeSaveFile
    // Display search sheet
    case search
    // Show settings
    case settings
    // Display Alert
    case showAlert(Message)
}

typealias PublishedShowSheet = Published<ShowSheet>
