//
//  FileUtils.swift
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
) -> Result<URL,Error> {
    let paths = FileManager.default.urls(for: searchPath, in: .userDomainMask)
    if paths.isEmpty { return .failure(LocalErrors.noSuchPath) }
    
    var base = paths[0]
    if addBundleId(searchPath) {
        var id = Bundle.main.bundleIdentifier
        if id == nil { id = "ColourViewer" }
        base = base.appendingPathComponent(id!)
    }
    if name == nil { return .success(base) }
    return .success(base.appendingPathComponent(name!))
}

/// Create an app directory
///
///Parameters:
///     in:     Search path

func createAppDirectory(_ searchPath: FileManager.SearchPathDirectory) -> Result<Void,Error> {
    var url: URL

    switch fileURL(nil, in: searchPath) {
    case .success(let ret): url = ret
    case .failure(let error): return .failure(error)
    }

    if urlExists(url) { return .success(Void()) }
    
    do {
        try FileManager.default.createDirectory(at: url,
                                        withIntermediateDirectories: true,
                                        attributes: nil)
    } catch {
        return .failure(error)
    }
    
    return .success(Void())
}

/// Check for the existance of a local URL
///
/// Parameters:
///     url:    the url to check

func urlExists(_ url: URL?) -> Bool {
    if url == nil { return false }
    return FileManager.default.fileExists(atPath: url!.path)
}

/// Check for the existance of a local file
///
/// Parameters:
///     url:    the url to check

func fileExists(_ name: String, in searchPath: FileManager.SearchPathDirectory) -> Bool {
    var url: URL
    
    switch fileURL(name, in: searchPath) {
    case .success(let ret): url = ret
    case .failure(_): return false
    }
    
    return urlExists(url)
}
