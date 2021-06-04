//
//  MyFilesExplorerApp.swift
//  Shared
//
//  Created by Russell Archer on 17/05/2021.
//

import SwiftUI

@main
struct MyFilesExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(path: "")  // Start the app by browsing the Dropbox root folder
            
            //            #if os(iOS)
            //            ContentView(path: "")  // Start the app by browsing the Dropbox root folder
            //            #elseif os(macOS)
            //            SplitView()
            //            #endif
        }
    }
}
