//
//  Observable.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ObservableBool: Combine.ObservableObject, Identifiable {
    /// Bool class for SwiftUI
    /// The class publishes that a change will occur to SwiftUI and
    /// the changed value for others
    ///
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<Bool, Never>()
    var bool: Bool {
        willSet { objectWillChange.send() }
        didSet { publisher.send(bool) }
    }
    
    init(_ bool: Bool = false) { self.bool = bool }
}

class ObservableInt: Combine.ObservableObject, Identifiable {
    /// Int class for SwiftUI
    /// The class publishes that a change will occur to SwiftUI and
    /// the changed value for others
    ///
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<Int, Never>()
    var number: Int {
        willSet { objectWillChange.send() }
        didSet { publisher.send(number) }
    }
    
    init(_ number: Int = 0) { self.number = number }
}

class ObservableString: Combine.ObservableObject, Identifiable {
    /// String class for SwiftUI
    /// The class publishes that a change will occur to SwiftUI and
    /// the changed value for others
    ///
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<String, Never>()
    var string: String {
        willSet { objectWillChange.send() }
        didSet { publisher.send(string) }
    }
    
    init(_ string: String = "") { self.string = string }
}
