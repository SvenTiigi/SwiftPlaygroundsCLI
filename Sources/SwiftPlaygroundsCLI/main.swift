//
//  main.swift
//
//
//  Created by Sven Tiigi on 12.02.20.
//

import Foundation

// Initialize SwiftPlaygroundsCLI
let swiftPlaygroundsCLI = SwiftPlaygroundsCLI()

#if DEBUG
swiftPlaygroundsCLI.debug(arguments: ["new"])
#else
// Start SwiftPlaygroundsCLI
swiftPlaygroundsCLI.start()
#endif
