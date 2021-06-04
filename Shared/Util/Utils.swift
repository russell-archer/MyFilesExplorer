//
//  Utils.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 22/05/2021.
//

import Foundation

struct Utils {
    
    /// Detects if the app is running as a preview
    static var isRunningPreview: Bool { ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" }
    
    static var isMocked: Bool {
        #if MOCK
        return true
        #else
        return false
        #endif
    }
}
