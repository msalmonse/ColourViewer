//
//  FontSize.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-02.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import SwiftUI

/// largerFont: return a font smaller by a number of steps
///
/// Parameters:
///     font:   the current font
///     by:     how many steps smaller

func largerFont(_ current: Font, by: Int = 1) -> Font {
    var font = current
    var count = 0
    while count < by {
        switch font {
        case .headline:     font = .title
        case .subheadline:  font = .headline
        case .body:         font = .subheadline
        case .callout:      font = .body
        case .caption:      font = .callout
        case .footnote:     font = .caption
        default:            return .largeTitle
        }
        count += 1
    }
    return font
}

/// smallerFont: return a font smaller by a number of steps
///
/// Parameters:
///     font:   the current font
///     by:     how many steps smaller

func smallerFont(_ current: Font, by: Int = 1) -> Font {
    var font = current
    var count = 0
    while count < by {
        switch font {
        case .largeTitle:   font = .title
        case .title:        font = .headline
        case .headline:     font = .subheadline
        case .subheadline:  font = .body
        case .body:         font = .callout
        case .callout:      font = .caption
        default:            return .footnote
        }
        count += 1
    }
    return font
}

/// textStyle: return the TextStyle of a font
///
/// Parameters:
///     font:   the current font

func textStyle(_ font: Font) -> Font.TextStyle {
    switch font {
    case .largeTitle:   return .largeTitle
    case .title:        return .title
    case .headline:     return .headline
    case .subheadline:  return .subheadline
    case .body:         return .body
    case .callout:      return .callout
    case .caption:      return .caption
    case .footnote:     return .footnote
    default:            return .footnote
    }

}
