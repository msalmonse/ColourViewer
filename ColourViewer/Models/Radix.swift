//
//  Radix.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-07-25.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI

/// Radix to use when editting Int's

enum Radix: Hashable {
    case octal
    case decimal
    case hexadecimal
    case unknown

    /// Label to describe radix
    var label: String {
        switch self {
        case .octal:
            return"Oct"
        case .decimal:
            return "Dec"
        case .hexadecimal:
            return "Hex"
        default:
            return ""
        }
    }

    /// Base for radix
    var base:Int {
        switch self {
        case .octal:
            return 8
        case .decimal:
            return 10
        case .hexadecimal:
            return 16
        default:
            return 0
        }
    }

    /// Format string for radix
    var format: String {
        switch self {
        case .octal:
            return"%o"
        case .decimal:
            return "%d"
        case .hexadecimal:
            return "%x"
        default:
            return ""
        }
    }

    /// Like allCases but in defined order
    static var all: [Radix] = [ .decimal, .hexadecimal, .octal ]

    /// Convert base to radix
    static func radix(for i: Int) -> Radix {
        switch i {
        case 8:
            return .octal
        case 10:
            return .decimal
        case 16:
            return .hexadecimal
        default:
            return .unknown
        }
    }
}
