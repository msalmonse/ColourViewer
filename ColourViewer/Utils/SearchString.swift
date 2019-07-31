//
//  SearchString.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-29.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine

struct SearchString {
    let min = 2
    let publisher = PassthroughSubject<String, Never>()
    var string = "" {
        didSet {
            if string.count >= min { publisher.send(string) }
        }
    }
    var isEmpty: Bool { return string.isEmpty }
}
