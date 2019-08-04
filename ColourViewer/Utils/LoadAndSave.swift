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

func load<T: Decodable>(_ filename: String) -> T? {
    let data: Data
    
    guard let file = fileURL(filename, in: .applicationSupportDirectory)
    else {
        return nil
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        return nil
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        return nil
    }
}

func save<T: Encodable>(_ obj: T, _ filename: String, as type: T.Type = T.self) -> Bool {
    var data: Data

/*    guard let file = fileURL(filename, in: .applicationSupportDirectory)
    else {
        return false
    }
*/
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        data = try encoder.encode(obj)
    } catch {
        return false
    }
    print(String(data: data, encoding: .utf8)!)

    return true
}

