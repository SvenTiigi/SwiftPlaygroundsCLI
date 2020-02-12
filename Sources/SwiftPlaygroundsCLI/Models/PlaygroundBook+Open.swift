//
//  PlaygroundBook+Open.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation
import SwiftCLI

// MARK: - Open

extension PlaygroundBook {
    
    /// Open PlaygroundBook
    func open() throws {
        // Open Playgrounds App
        _ = try SwiftCLI.Task.capture(
            bash: "open -a Playgrounds.app"
        )
        // Sleep for one second to ensure Playgrounds has finished loading
        // This is needed because otherwise if we immeditally open the
        // file SwiftPlayground crashes
        Thread.sleep(forTimeInterval: 2)
        // Open generated PlaygroundBook at destination File Path
        _ = try SwiftCLI.Task.capture(
            bash: "open \"\(self.destinationFilePath.rawValue)\""
        )
    }
    
}
