//
//  UserSettings.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-23.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import UserDefaults

final class UserSettings: ObservableObject, Identifiable {
    let id = UUID()
    let objectWillChange = ObservableObjectPublisher()

    private static let settings = UserSettings()
    static var autoload: Bool { return settings.autoload }

    @UserDefault("Autoload", defaultValue: true)
    var autoload: Bool {
        willSet { objectWillChange.send() }
    }

    init() { return }
}
