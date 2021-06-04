//
//  ContentViewBody.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 26/05/2021.
//

import SwiftUI

struct ContentViewBody: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var path = ""
    var isRoot: Bool { path == "" }
    private var navTitle: String { viewModel.hasContent ? (viewModel.path ?? "/ (root)") : "Loading..." }
    
    var body: some View {
        #if os(iOS)
        VStack {
            if viewModel.hasContent {
                
                FolderEntriesView(viewModel: viewModel)
                
            } else if viewModel.gettingData {

                GettingDataView()
                
            } else if viewModel.hasError {
                
                ErrorView(viewModel: viewModel)
            }
        }
        .navigationTitle(navTitle)
        .navigationBarTitleDisplayMode(isRoot ? .large : .inline)
        .onAppear() {
            if viewModel.path == nil { viewModel.path = path }
            try? viewModel.getDropboxContent()
        }
        #elseif os(macOS)
        VStack {
            if viewModel.hasContent {
                
                FolderEntriesView(viewModel: viewModel)
                
            } else if viewModel.gettingData {

                GettingDataView()
                
            } else if viewModel.hasError {
                
                ErrorView(viewModel: viewModel)
            }
        }
        .navigationTitle(navTitle)
        .onAppear() {
            if viewModel.path == nil { viewModel.path = path }
            try? viewModel.getDropboxContent()
        }
        #endif
    }
}

struct FolderBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewBody()
    }
}
