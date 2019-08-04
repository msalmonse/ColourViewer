//
//  FilePath.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// fetch the path of a file
///
/// Parameters:
///     name:       filename in directory
///     in:             directory code

func filePath(_ name: String,
              in sp: FileManager.SearchPathDirectory = .applicationSupportDirectory) -> URL? {
    let paths = FileManager.default.urls(for: sp, in: .userDomainMask)
    if paths.isEmpty { return nil }
    return paths[0].appendingPathComponent(name)
}
