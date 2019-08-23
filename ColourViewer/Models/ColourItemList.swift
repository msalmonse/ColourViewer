//
//  ColourItemList.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine
import os.log

/// Wrapper class for [ColourItem], mainly to add load() and save()

class ColourItemList: ObservableObject, Identifiable {
    static let saveFile = "ColourItemHistory.json"
    static let saveDir = FileManager.SearchPathDirectory.applicationSupportDirectory

    let id = UUID()

    var changeCount = 0
    var noChanges: Bool { return list.isEmpty || changeCount == 0}

    var saveURL: URL? = nil
    var noSaveURL: Bool { return saveURL == nil }

    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<Void, Never>()

    var list: [ColourItem] {
        willSet { objectWillChange.send() }
        didSet {
            changeCount += 1
            publisher.send()
        }
    }

    var isEmpty: Bool { list.isEmpty }

    init(_ inList: [ColourItem] = [], loadedFrom: URL? = nil) {
        self.list = inList
        self.saveURL = loadedFrom
    }

    convenience init() { self.init([]) }

    // Save to file
    func save(to: String = ColourItemList.saveFile) -> Result<URL,Error> {
        var url: URL

        switch fileURL(to) {
        case .success(let ret): url = ret
        case .failure(let error): return .failure(error)
        }

        switch saveAsJSON(list, to: url) {
        case .success:
            changeCount = 0
            saveURL = url
            return .success(url)
        case .failure(let error):
            os_log("Error saving to '%s': %s", type: .info, to, "\(error)")
            return .failure(error)
        }
    }

    // Initialize from file
    static func load(_ from: String = saveFile) -> ColourItemList {
        var url: URL

        switch fileURL(from) {
        case .success(let ret): url = ret
        case .failure: return ColourItemList([])
        }

        switch loadFromJSON(url, as: [ColourItem].self) {
        case .success(let list):
            return ColourItemList(list, loadedFrom: url)
        case .failure(let error):
            os_log("Error loading from '%s': %s", type: .info, from, "\(error)")
            return ColourItemList([])
        }
    }

    // Reload form file
    func reload() -> Result<URL, Error> {
        guard let url = saveURL else {
            return .failure(LocalErrors.unknownError)
        }

        switch loadFromJSON(url, as: [ColourItem].self) {
        case .success(let list):
            self.list = list
            return .success(url)
        case .failure(let error):
            os_log("Error reloading from '%s': %s", type: .info, url.lastPathComponent, "\(error)")
            return .failure(error)
        }
    }

    // Remove save file
    func removeSaved() -> Result<Void, Error> {
        if saveURL == nil { return .failure(LocalErrors.fileNotFound) }
        let rmURL = saveURL!
        saveURL = nil
        switch urlRemove(rmURL) {
        case .success: return .success(Void())
        case .failure(let error):
            os_log("Error removing '%s': %s", type: .info, rmURL.path, "\(error)")
            return .failure(error)
        }
    }
}
