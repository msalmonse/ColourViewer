//
//  LoadAndSave.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// Load a JSON file into an object
/// Based on sample code from Apple
///
/// Parameters:
///     filename:       name of file to load

func loadFromJSON<T: Decodable>(_ obj: T, _ filename: String) -> Result<T,Error> {
    let data: Data
    var url: URL
   
    switch fileURL(filename) {
    case .success(let ret): url = ret
    case .failure(let error): return .failure(error)
    }
    
    do {
        data = try Data(contentsOf: url)
    } catch {
        return .failure(error)
    }
    
    do {
        let decoder = JSONDecoder()
        let t = try decoder.decode(T.self, from: data)
        return .success(t)
    } catch {
        return .failure(error)
    }
}

func saveAsJSON<T: Encodable>(_ obj: T, to filename: String,
        in searchPath: FileManager.SearchPathDirectory = .applicationSupportDirectory
) -> Result<Void,Error> {
    var url: URL
    var data: Data

    switch fileURL(filename, in: searchPath) {
    case .success(let ret): url = ret
    case .failure(let error): return .failure(error)
    }

    switch createAppDirectory(searchPath) {
    case .success(_): let _ = 0
    case .failure(let error): return .failure(error)
    }

    do {
        let encoder = JSONEncoder()
        data = try encoder.encode(obj)
    } catch {
        return .failure(error)
    }
    
    do {
        try data.write(to: url)
    } catch {
        print("Error writing to \(filename): \(error)")
        return .failure(error)
    }

    return .success(Void())
}

