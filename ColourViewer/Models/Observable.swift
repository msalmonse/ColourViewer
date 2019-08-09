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

/// Generic wrapper for ObservableObjects

class Observable<T>: Combine.ObservableObject, Identifiable {
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()
    let publisher = PassthroughSubject<T, Never>()
    var value: T {
        willSet { objectWillChange.send() }
        didSet { publisher.send(value) }
    }
    
    init(_ initValue: T) { self.value = initValue }
}

typealias ObservableBool = Observable<Bool>
typealias ObservableInt = Observable<Int>
typealias ObservableString = Observable<String>
