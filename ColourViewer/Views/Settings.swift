//
//  Settings.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-23.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import UserDefaults

struct Settings: View {
    @ObservedObject var settings = UserSettings()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let nameVersion: String

    init() {
        let name = bundledData(key: "CFBundleName")
        let version = bundledData(key: "CFBundleShortVersionString")
        let build = bundledData(key: "CFBundleVersion")

        var string = ""
        if name != nil {
            string = name!
            if version != nil {
                string += " - \(version!)"
                if build != nil {
                    string += "(\(build!))"
                }
            }
        }
        self.nameVersion = string
    }

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "gear")
                .font(Font.title.weight(.bold))
                .foregroundColor(.primary)
                Spacer()
                // Button to close the sheet
                Button(
                    action: { self.mode.wrappedValue.dismiss() },
                    label: {
                        Image(systemName: "clear")
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.primary)
                        .padding(.trailing, 10)
                    }
                )
            }
            .padding(10)
            Spacer()

            Toggle("Autoload history?", isOn: $settings.autoload)
            .padding()
            .overlay(strokedRoundedRectangle(cornerRadius: 10))

            Spacer()
            Text(nameVersion).padding(5)
        }
        .frame(width: 256)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
