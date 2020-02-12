//
//  SwiftPlaygroundsCLI.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation
import SwiftCLI

// MARK: - SwiftPlaygroundsCLI

/// The SwiftPlaygroundsCLI
struct SwiftPlaygroundsCLI {
    
    // MARK: Properties
    
    /// The CLI
    private let cli = SwiftCLI.CLI(
        name: "swiftplaygrounds",
        version: "1.0.0",
        description: "Generate SwiftPlaygrounds"
    )
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameter commands: The Commands.`
    init(commands: [SwiftCLI.Command] = [NewCommand()]) {
        self.cli.commands = commands
    }
    
}

// MARK: - Start

extension SwiftPlaygroundsCLI {
    
    /// Start CLI
    @discardableResult
    func start() -> Int32 {
        self.cli.go()
    }
    
}

// MARK: - Debug

extension SwiftPlaygroundsCLI {
    
    /// Debug CLI with arguments
    /// - Parameter arguments: The arguments
    @discardableResult
    func debug(arguments: [String]) -> Int32 {
        self.cli.go(with: arguments)
    }
    
}
