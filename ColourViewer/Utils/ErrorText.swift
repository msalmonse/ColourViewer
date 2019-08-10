//
//  ErrorText.swift
//  ColourViewer
//
//  Created by Michael Salmon on 2019-08-06.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

/// Return the description of an error

func errorText(_ err: Error) -> String {
    return err.localizedDescription
}

/// The error description in a message

func errorMessage(_ err: Error, _ location: ErrorLocation) -> Message {
    let subject = "Error " + String(describing: location)
    return Message(errorText(err), subject: subject)
}

/// Where did the error occur
enum ErrorLocation: String {
    case fileSave = "saving to file"
    case removeFile = "removing file"
}
