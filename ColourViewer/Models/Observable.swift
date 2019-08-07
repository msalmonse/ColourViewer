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
    var value: Bool {
        willSet { objectWillChange.send() }
        didSet { publisher.send(value) }
    }
    
    init(_ initValue: Bool = false) { self.value = initValue }
}

class ObservableInt: Combine.ObservableObject, Identifiable {
    /// Int class for SwiftUI
    /// The class publishes that a change will occur to SwiftUI and
    /// the changed value for others
    ///
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<Int, Never>()
    var value: Int {
        willSet { objectWillChange.send() }
        didSet { publisher.send(value) }
    }
    
    init(_ initValue: Int = 0) { self.value = initValue }
}

class ObservableString: Combine.ObservableObject, Identifiable {
    /// String class for SwiftUI
    /// The class publishes that a change will occur to SwiftUI and
    /// the changed value for others
    ///
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<String, Never>()
    var value: String {
        willSet { objectWillChange.send() }
        didSet { publisher.send(value) }
    }
    
    init(_ initValue: String = "") { self.value = initValue }
}
