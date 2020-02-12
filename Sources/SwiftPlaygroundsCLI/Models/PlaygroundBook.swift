//
//  File.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation
import SwiftCLI

// MARK: - PlaygroundBook

/// The PlaygroundBook
struct PlaygroundBook {
    
    // MARK: Properties
    
    /// The name of the PlaygroundBook
    let name: String
    
    /// The optional Content
    let content: String?
    
    /// The FileManager
    let fileManager: FileManager
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - name: The optional name of the PlaygroundBook. When passing nil the default name is used. Default value `nil`
    ///   - content: The optional Content. Default value `nil`
    ///   - fileManager: The FileManager. Default value `.default`
    init(
        name: String? = nil,
        content: String? = nil,
        fileManager: FileManager = .default
    ) {
        self.name = name ?? PlaygroundBook.makeDefaultName()
        self.content = content
        self.fileManager = fileManager
    }
    
}

// MARK: - Make Default Name

private extension PlaygroundBook {
    
    /// Make default PlaygroundBook Name from Date
    /// - Parameter date: The Date. Default value `.init`
    static func makeDefaultName(date: Date = .init()) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let date = formatter.string(from: date)
        return "Playground \(date.replacingOccurrences(of: "/", with: "-"))"
    }
    
}

// MARK: - Generate

extension PlaygroundBook {
    
    /// The PlaygroundBook Template File Path
    private var templateFilePath: Path {
        .init(
            "/Applications/Playgrounds.app/Contents/Resources/Templates/BlankWithModules.playgroundbook"
        )
    }
   
    /// The destination File Path
    private var destinationFilePath: Path {
        .init(
            "~/Library/Mobile Documents/iCloud~com~apple~Playgrounds/Documents/\(self.name).playgroundbook"
        )
    }

    /// The Manifest File Path
    private var manifestFilePath: Path {
        .init(
            "~/Library/Mobile Documents/iCloud~com~apple~Playgrounds/Documents/\(self.name).playgroundbook/Contents/Chapters/Chapter1.playgroundchapter/Pages/My Playground.playgroundpage/Manifest.plist"
        )
    }
    
    /// Generate PlaygroundBook in iCloud Directory
    func generate() throws {
        // Verify file does not exists
        guard !self.fileManager.fileExists(atPath: self.destinationFilePath.rawValue) else {
            // Otherwise return out of function
            return
        }
        // Try to copy Template File to Destination File Path
        try self.fileManager.copyItem(
            atPath: self.templateFilePath.rawValue,
            toPath: self.destinationFilePath.rawValue
        )
        // Verify Manifest Content is available
        guard let manifestContent = try? String(contentsOfFile: self.manifestFilePath.rawValue) else {
            // Otherwise return out of functuon
            return
        }
        // Replace "My Playground" with PlaygroundBook Name so that the name appears in the Top-Bar
        let updatedManifestContent = manifestContent.replacingOccurrences(
            of: "My Playground",
            with: self.name
        )
        // Write updated ManifestContent
        try updatedManifestContent.write(
            toFile: self.manifestFilePath.rawValue,
            atomically: false,
            encoding: .utf8
        )
    }
    
}

// MARK: - Open

extension PlaygroundBook {
    
    /// The Application Name
    private var applicationName: String {
        "Playgrounds.app"
    }
    
    /// Open PlaygroundBook
    func open() throws {
        // Open Playgrounds App
        _ = try SwiftCLI.Task.capture(
            bash: "open -a \(self.applicationName)"
        )
        // Sleep for one second to ensure Playgrounds has loaded
        Thread.sleep(forTimeInterval: 1.5)
        // Open generated PlaygroundBook at destination File Path
        _ = try SwiftCLI.Task.capture(
            bash: "open \"\(self.destinationFilePath.rawValue)\""
        )
    }
    
}
