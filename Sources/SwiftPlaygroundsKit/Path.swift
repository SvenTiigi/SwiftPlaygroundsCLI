//
//  Path.swift
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
    /// - Parameters:
    ///   - parents: The parent Paths
    ///   - rawValue: The raw value
    init(
        parents: Path...,
        rawValue: String
    ) {
        let parentPaths: [String] = parents.map { parent in
            let parent = parent.rawValue
            if parent.last != "/" {
                return parent + "/"
            } else {
                return parent
            }
        }
        self.rawValue = parentPaths.joined() + NSString(string: rawValue).expandingTildeInPath
    }
    
}
