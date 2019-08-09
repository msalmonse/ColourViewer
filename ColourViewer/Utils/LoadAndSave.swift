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

func loadFromJSON<T: Decodable>(_ url: URL, as type: T.Type = T.self) -> Result<T,Error> {
    let data: Data

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

func saveAsJSON<T: Encodable>(_ obj: T, to url: URL) -> Result<Void,Error> {
    var data: Data

    switch createDirectoryContaining(url: url) {
    case .success(): break
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
        print("Error writing to \(url.path): \(error)")
        return .failure(error)
    }

    return .success(Void())
}

