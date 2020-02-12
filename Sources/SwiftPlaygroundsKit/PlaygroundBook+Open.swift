//
//  PlaygroundBook+Open.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// MARK: - Open

public extension PlaygroundBook {
    
    /// Open PlaygroundBook
    /// - Parameter executable: The executable to execute a bash command
    func open(executable: (String) throws -> Void) throws {
        // Open Playgrounds App
        try executable("open -a Playgrounds.app")
        // Sleep for one second to ensure Playgrounds has finished loading
        // This is needed because otherwise if we immeditally open the
        // file SwiftPlayground crashes
        Thread.sleep(forTimeInterval: 2)
        // Open generated PlaygroundBook at destination File Path
        try executable("open \"\(self.destinationFilePath.rawValue)\"")
    }
    
}
