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
    var saveURL: URL? = nil

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
    func save(to: String = ColourItemList.saveFile) -> Result<Void,Error> {
        var url: URL
        
        switch fileURL(to) {
        case .success(let ret): url = ret
        case .failure(let error): return .failure(error)
        }

        switch saveAsJSON(list, to: url) {
        case .success(_):
            changeCount = 0
            saveURL = url
            return .success(Void())
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
        case .failure(_): return ColourItemList([])
        }

        switch loadFromJSON(url, as: [ColourItem].self) {
        case .success(let list):
            return ColourItemList(list, loadedFrom: url)
        case .failure(let error):
            os_log("Error loading from '%s': %s", type: .info, from, "\(error)")
            return ColourItemList([])
        }
    }
}
