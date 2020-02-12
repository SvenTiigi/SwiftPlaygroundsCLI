//
//  PlaygroundBook+Content.swift
//  
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// MARK: - Content

public extension PlaygroundBook {
    
    /// The PlaygroundBook Content
    enum Content: Equatable, Hashable {
        /// Default Content
        case `default`
        /// View Content
        case view
        /// Remove Content from URL
        case remote(url: String)
    }
    
}

// MARK: - RawValue

extension PlaygroundBook.Content {
    
    /// The Content raw value
    var rawValue: String {
        switch self {
        case .default:
            return """
            import Foundation
            
            print("Hello Developer")
            """
        case .remote(let url):
            if let code = self.loadCode(from: url) {
                return code
            } else {
                return "// Unable to load content from: \(url)"
            }
        case .view:
            return """
            import PlaygroundSupport
            import SwiftUI

            struct MyView: View {
                
                var body: some View {
                    Text("Hello Developer")
                        .font(.largeTitle)
                }
                
            }

            let view = MyView()
            PlaygroundPage.current.setLiveView(view)
            """
        }
    }
    
}

// MARK: - Load Code from URL

private extension PlaygroundBook.Content {
    
    /// Load Code from URL
    /// - Parameter url: The URL string
    func loadCode(from url: String) -> String? {
        // Verify URL is valid
        guard var url = URL(string: url) else {
            // Otherwise return nil
            return nil
        }
        // Initialize absoulte URL string
        let absoulteURLString = url.absoluteString
        // Check if URL contains gist.github.com and does not contain raw path
        if absoulteURLString.contains("gist.github.com")
            && !absoulteURLString.contains("/raw") {
            // Re-Initialize URL by appending raw path
            url = url.appendingPathComponent("raw")
        } else if let gitHubRange = absoulteURLString.range(of: "github.com/") {
            // If github.com is available in URL make URL suffix
            let urlSuffix = absoulteURLString[gitHubRange.upperBound...]
            // Initialize raw URL suffix by removing blob path component
            let rawURLSuffix = urlSuffix.replacingOccurrences(of: "/blob/", with: "/")
            // Verify raw content URL can be initialize
            guard let rawContentURL = URL(string: "https://raw.githubusercontent.com/" + rawURLSuffix) else {
                // Otherwise return nil
                return nil
            }
            // Re-Initialize URL with raw content URL
            url = rawContentURL
        }
        do {
            // Try to load Code from URL
            let code = try String(
                contentsOf: url,
                encoding: .utf8
            )
            // Return Code
            return """
            // Loaded from \(absoulteURLString)
            
            \(code)
            """
        } catch {
            // On Error return nil
            return nil
        }
    }
    
}
