//
//  LocalErrors.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-05.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// Errors local to the app

enum LocalErrors: Error {
    case fileNameError
    case fileNotFound
    case noSuchPath
    case unknownError
}
