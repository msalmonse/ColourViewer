//
//  SearchString.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine

class SearchString: Combine.ObservableObject, Identifiable {
    let id = UUID()
    let min = 2
    let publisher = PassthroughSubject<String, Never>()
    let objectWillChange = ObservableObjectPublisher()
    var string = "" {
        willSet { objectWillChange.send() }
        didSet { if string.count >= min { publisher.send(string) } }
    }
    var isEmpty: Bool { return string.isEmpty }
}
