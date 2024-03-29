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
///     searchPath:     Search path

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

/// Create a directory containing a url
///
/// Parameters:
///     url:     the full url of the file
///     trim:   the number of components to trim

func createDirectoryContaining(url urlIn: URL, trim: Int = 1) -> Result<Void, Error> {
    var url = urlIn
    var count = 0
    // trim trailing path components
    while count < trim {
        url.deleteLastPathComponent()
        count += 1
    }

    if url.path.isEmpty { return .failure(LocalErrors.fileNameError) }

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
    case .failure: return false
    }

    return urlExists(url)
}

/// Remove a file

func urlRemove(_ url: URL) -> Result<Void,Error> {
    do {
        try FileManager.default.removeItem(at: url)
    } catch {
        return .failure(error)
    }

    return .success(Void())
}

/// Get the url for the temorary directory

func tempDirURL() -> URL {
    return FileManager.default.temporaryDirectory
}
