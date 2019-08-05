//
//  FilePath.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// Check whether the bundle id should be added to the path
///
/// Parameters
///     searchPath:     the directory code

fileprivate func addBundleId(_ searchPath: FileManager.SearchPathDirectory) -> Bool {
    switch searchPath {
    case .applicationSupportDirectory: return true
    default: return false
    }
}

/// fetch the path of a file
///
/// Parameters:
///     name:       filename in directory
///     in:             directory code

func fileURL(_ name: String?,
              in searchPath: FileManager.SearchPathDirectory = .applicationSupportDirectory
) -> URL? {
    let paths = FileManager.default.urls(for: searchPath, in: .userDomainMask)
    if paths.isEmpty { return nil }
    
    var base = paths[0]
    if addBundleId(searchPath) {
        var id = Bundle.main.bundleIdentifier
        if id == nil { id = "ColourViewer" }
        base = base.appendingPathComponent(id!)
    }
    if name == nil { return base }
    return base.appendingPathComponent(name!)
}

/// Create an app directory
///
///Parameters:
///     in:     Search path

func createAppDirectory(_ searchPath: FileManager.SearchPathDirectory) -> Bool {
    guard let path = fileURL(nil, in: searchPath) else {
        return false
    }
    if FileManager.default.fileExists(atPath: path.path) {
        return true
    }
    
    do {
        try FileManager.default.createDirectory(at: path,
                                        withIntermediateDirectories: true,
                                        attributes: nil)
    } catch {
        print("Error creating '\(path)': \(error)")
        return false
    }
    
    return true
}
