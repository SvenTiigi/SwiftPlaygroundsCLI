//
//  PlaygroundBook+Generate.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// MARK: - Generate

public extension PlaygroundBook {
    
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
        // Check if Manifest Content is available
        if let manifestContent = try? String(contentsOfFile: self.manifestFilePath.rawValue) {
            // Replace "My Playground" with PlaygroundBook Name so that the name appears in the Top-Bar
            let updatedManifestContent = manifestContent.replacingOccurrences(
                of: self.defaultPlaygroundPageFileName,
                with: self.name
            )
            // Write updated ManifestContent
            try? updatedManifestContent.write(
                toFile: self.manifestFilePath.rawValue,
                atomically: false,
                encoding: .utf8
            )
        }
        // Write Content raw value to Main Swift File Path
        try? self.content.rawValue.write(
            toFile: self.mainSwiftFilePath.rawValue,
            atomically: false,
            encoding: .utf8
        )
    }
    
}

// MARK: - Default PlaygroundPage File Name

extension PlaygroundBook {
    
    /// The default Playground Page File Name
    var defaultPlaygroundPageFileName: String {
        "My Playground"
    }
    
}

// MARK: - Paths

extension PlaygroundBook {
    
    /// The PlaygroundBook Template File Path
    var templateFilePath: Path {
        .init(
            rawValue: "/Applications/Playgrounds.app/Contents/Resources/Templates/BlankWithModules.playgroundbook"
        )
    }
    
    var iCloudPath: Path {
        .init(
            rawValue: "~/Library/Mobile Documents/iCloud~com~apple~Playgrounds/Documents"
        )
    }
   
    /// The destination File Path
    var destinationFilePath: Path {
        .init(
            parents: self.iCloudPath,
            rawValue: "\(self.name).playgroundbook"
        )
    }
    
    /// The Playground Page File Path
    var playgroundPageFilePath: Path {
        .init(
            parents: self.destinationFilePath,
            rawValue: "Contents/Chapters/Chapter1.playgroundchapter/Pages/\(self.defaultPlaygroundPageFileName).playgroundpage"
        )
    }

    /// The Manifest File Path
    var manifestFilePath: Path {
        .init(
            parents: self.playgroundPageFilePath,
            rawValue: "Manifest.plist"
        )
    }
    
    var mainSwiftFilePath: Path {
        .init(
            parents: self.playgroundPageFilePath,
            rawValue: "main.swift"
        )
    }
    
}
