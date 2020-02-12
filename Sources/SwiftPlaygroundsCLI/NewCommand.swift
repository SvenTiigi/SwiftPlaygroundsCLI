//
//  File.swift
//  
//
//  Created by Sven Tiigi on 11.02.20.
//

import Foundation
import SwiftCLI
import SwiftPlaygroundsKit

// MARK: - NewCommand

/// The NewCommand
final class NewCommand {
    
    /// The optional PlaygroundBook Name
    @Param
    var playgroundBookName: String?
    
    /// The View Content Flag
    @Flag("-v", "--view", description: "Generate Playground with SwiftUI content")
    var viewContent: Bool
    
    /// The remote URL Content Key
    @Key("-u", "--url", description: "Generate Playground with content from a URL")
    var remoteContentURL: String?
    
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
        // Declare PlaygroundBook Content
        let content: PlaygroundBook.Content
        // Check if ViewContent is enabled
        if self.viewContent {
            // Set View Content
            content = .view
        } else if let remoteContentURL = self.remoteContentURL {
            // If a remote content URL is available use remote
            content = .remote(url: remoteContentURL)
        } else {
            // Otherwise use default
            content = .default
        }
        // Initialize a PlaygroundBook
        let playgroundBook = PlaygroundBook(
            name: self.playgroundBookName,
            content: content
        )
        do {
            // Try to generate PlaygroundBook
            try playgroundBook.generate()
            // Try to open PlaygroundBook
            try playgroundBook.open { command in
                _ = try SwiftCLI.Task.capture(bash: command)
            }
            // Print out success
            self.stdout <<< "Playground generated. Happy coding 👨‍💻👩‍💻"
        } catch {
            // Print out error
            self.stderr <<< "Oops something went wrong 🙈.\nError: \(error)"
        }
    }
    
}
