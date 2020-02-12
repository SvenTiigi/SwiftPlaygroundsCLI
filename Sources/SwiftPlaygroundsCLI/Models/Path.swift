//
//  File.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// MARK: - Path

/// The Path
struct Path {
    
    /// The raw value
    let rawValue: String
    
    /// Designated Initializer
    /// - Parameter rawValue: The raw value
    init(_ rawValue: String) {
        self.rawValue = NSString(string: rawValue).expandingTildeInPath
    }
    
}

// MARK: - ExpressibleByStringLiteral

extension Path: ExpressibleByStringLiteral {
    
    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    init(stringLiteral value: String) {
        self.init(value)
    }
    
}
