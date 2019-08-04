//
//  ColourItemList.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

class ColourItemList {
    static let savefile = "ColourItemHistory.json"
    static let saveDir = FileManager.SearchPathDirectory.applicationSupportDirectory

    let list: [ColourItem] = []
}
