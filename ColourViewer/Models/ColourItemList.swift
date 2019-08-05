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
    var hasSaveFile = fileExists(ColourItemList.saveFile, in: ColourItemList.saveDir)

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
    
    init(_ inList: [ColourItem] = []) {
        self.list = inList
    }
    
    convenience init() { self.init([]) }
    
    // Save to file
    func save(to: String = ColourItemList.saveFile) -> Result<Void,Error> {
        switch saveAsJSON(list, to: to) {
        case .success(_):
            hasSaveFile = true
            changeCount = 0
            return .success(Void())
        case .failure(let error):
            os_log("Error saving to '%s': %s", type: .info, to, "\(error)")
            return .failure(error)
        }
    }
    
    // Initialize from file
    static func load(_ from: String = saveFile) -> ColourItemList {
        switch loadFromJSON(from, as: [ColourItem].self) {
        case .success(let list): return ColourItemList(list)
        case .failure(let error):
            os_log("Error loading from '%s': %s", type: .info, from, "\(error)")
            return ColourItemList([])
        }
    }
}
