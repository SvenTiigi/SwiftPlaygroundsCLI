//
//  File.swift
//  
//
//  Created by Sven Tiigi on 11.02.20.
//

import Foundation
import SwiftCLI

// MARK: - NewCommand

/// The NewCommand
final class NewCommand {
    
    /// The optional PlaygroundBook Name
    @Param
    var playgroundBookName: String?
    
}

// MARK: - Command

extension NewCommand: Command {
    
    /// The name of the command or command group
    var name: String {
        "new"
    }
    
    /// A concise description of what this command or group is
    var shortDescription: String {
        "Generate a new Playground"
    }
    
    /// A longer description of how to use this command or group
    var longDescription: String {
        self.shortDescription
    }
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        // Initialize a PlaygroundBook
        let playgroundBook = PlaygroundBook(
            name: self.playgroundBookName
        )
        do {
            // Try to generate
            try playgroundBook.generate()
            // Try to open
            try playgroundBook.open()
            // Print out success
            self.stdout <<< "Playground generated. Happy coding 👨‍💻👩‍💻"
        } catch {
            // Print out error
            self.stderr <<< "Oops something went wrong 🙈.\nError: \(error)"
        }
    }
    
}
