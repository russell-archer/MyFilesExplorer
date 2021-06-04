//
//  ContentView.swift
//  Shared
//
//  Created by Russell Archer on 17/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    var path = ""
    var isRoot: Bool { path == "" }

    var body: some View {
        
        if isRoot {
            
            #if os(iOS)
            NavigationView {
                ContentViewBody(viewModel: viewModel, path: path)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            #elseif os(macOS)
            NavigationView {
                ContentViewBody(viewModel: viewModel, path: path)
                    .frame(width: 350)
            }
            #endif
            
        } else {
            
            #if os(iOS)
            ContentViewBody(viewModel: viewModel, path: path)
            #elseif os(macOS)
            NavigationView {
                ContentViewBody(viewModel: viewModel, path: path)
                    .frame(width: 350)
            }
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(path: "")
    }
}
