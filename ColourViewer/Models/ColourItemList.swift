//
//  ColourItemList.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine

/// Wrapper class for [ColourItem], mainly to add load() and save()

class ColourItemList: ObservableObject, Identifiable {
    static let saveFile = "ColourItemHistory.json"
    static let saveDir = FileManager.SearchPathDirectory.applicationSupportDirectory

    let id = UUID()
    var changeCount = 0
    
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<Void, Never>()
    
    var list: [ColourItem] {
        willSet { objectWillChange.send() }
        didSet {
            changeCount += 1
            publisher.send()
        }
    }
    
    init(_ inList: [ColourItem] = []) {
        self.list = inList
    }
    
    convenience init() { self.init([]) }
    
    // Save to file
    func save(to: String = ColourItemList.saveFile) -> Bool {
        return saveAsJSON(list, to)
    }
    
    // Initialize from file
    static func load(_ from: String = saveFile) -> ColourItemList {
        let newList: [ColourItem]? = loadFromJSON(from)
        return .init((newList == nil) ? [] : newList!)
    }
}
