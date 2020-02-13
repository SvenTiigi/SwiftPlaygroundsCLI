//
//  SwiftPlaygroundsCLI+NewCommand.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation
import SwiftCLI
import SwiftPlaygroundsKit

// MARK: - NewCommand

extension SwiftPlaygroundsCLI {
    
    /// The NewCommand
    final class NewCommand {
        
        /// The optional PlaygroundBook Name
        @Param
        var playgroundBookName: String?
        
        /// Bool value if SwiftUI Content should be generated
        @Flag("-v", "--view", description: "Generate a Playground with a SwiftUI template")
        var viewContent: Bool
        
        /// The remote URL Content Key
        @Key("-u", "--url", description: "Generate a Playground with contents from a URL")
        var remoteContentURL: String?
        
        /// Bool value if Swift Playground should be generated silently without opening SwiftPlaygrounds application
        @Flag("-s", "--silent", description: "Generate a Playground without opening SwiftPlaygrounds application")
        var silent: Bool
        
    }
    
}

// MARK: - Command

extension SwiftPlaygroundsCLI.NewCommand: Command {
    
    /// The name of the command or command group
    var name: String {
        "new"
    }
    
    /// A concise description of what this command or group is
    var shortDescription: String {
        "Generate a new Swift Playground"
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
            // Check if silent is disabled
            if !self.silent {
                // Try to open PlaygroundBook
                try playgroundBook.open { command in
                    _ = try SwiftCLI.Task.capture(bash: command)
                }
            }
            // Print out success
            self.stdout <<< "Swift Playground generated. Happy coding 👨‍💻👩‍💻"
        } catch {
            // Print out error
            self.stderr <<< "Oops something went wrong 🙈.\nError: \(error)"
        }
    }
    
}
