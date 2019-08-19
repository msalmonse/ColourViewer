//
//  Message.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// An identifiable string

struct Message: Identifiable {
    let id = UUID()
    let subject: String?
    let text: String

    init(_ text: String, subject: String? = nil ) {
        self.subject = subject
        self.text = text
    }
}
