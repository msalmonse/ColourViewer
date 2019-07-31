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
    /// A wrapper for String that can be used in SwiftUI
    ///
    /// As well as informing SwiftUI that it's value will change this class also publishes it's value
    /// via publisher if the length of the string is greater than or equal to min
    ///
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
