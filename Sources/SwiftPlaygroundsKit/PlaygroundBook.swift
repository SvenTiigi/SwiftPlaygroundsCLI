//
//  PlaygroundBook.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// MARK: - PlaygroundBook

/// The PlaygroundBook
public struct PlaygroundBook {
    
    // MARK: Properties
    
    /// The name of the PlaygroundBook
    public let name: String
    
    /// The Content
    public let content: Content
    
    /// The FileManager
    public let fileManager: FileManager
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - name: The optional name of the PlaygroundBook. When passing nil the default name is used. Default value `nil`
    ///   - content: The Content. Default value `.default`
    ///   - fileManager: The FileManager. Default value `.default`
    public init(
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
