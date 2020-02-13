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
        // To prevent a Playgrounds.app Crash we wait for two seconds
        // to ensure that the Playgrounds.apps has been started properly
        // before opening the Playground file. Otherwise the Playgrounds.app crashes 🙈
        Thread.sleep(forTimeInterval: 2)
        // Open generated PlaygroundBook at destination File Path
        try executable("open \"\(self.destinationFilePath.rawValue)\"")
    }
    
}
