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

func errorMessage(_ err: Error) -> Message {
    return Message(errorText(err))
}
