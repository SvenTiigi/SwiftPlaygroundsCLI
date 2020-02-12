//
//  File.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// MARK: - PlaygroundBook

/// The PlaygroundBook
struct PlaygroundBook {
    
    // MARK: Properties
    
    /// The name of the PlaygroundBook
    let name: String
    
    /// The Content
    let content: Content
    
    /// The FileManager
    let fileManager: FileManager
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - name: The optional name of the PlaygroundBook. When passing nil the default name is used. Default value `nil`
    ///   - content: The Content. Default value `.default`
    ///   - fileManager: The FileManager. Default value `.default`
    init(
        name: String? = nil,
        content: Content = .default,
        fileManager: FileManager = .default
    ) {
        let makeDefaultName: () -> String = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            let date = formatter.string(from: .init())
            return "Playground \(date.replacingOccurrences(of: "/", with: "-"))"
        }
        self.name = name ?? makeDefaultName()
        self.content = content
        self.fileManager = fileManager
    }
    
}
