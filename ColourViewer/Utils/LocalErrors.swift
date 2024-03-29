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

extension LocalErrors: LocalizedError {
    // descriptions
    var errorDescription: String? {
        switch self {
        case .fileNameError:    return "File name error"
        case .fileNotFound:     return "File not found"
        case .noSuchPath:       return "The search path is not defined"
        case .unknownError:     return "The exact cause of thr error is not known"
        }
    }
}
