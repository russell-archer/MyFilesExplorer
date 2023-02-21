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
        VStack {
            if viewModel.hasContent {
                
                FolderEntriesView(viewModel: viewModel)
                
            } else if viewModel.gettingData {

                GettingDataView()
                
            } else if viewModel.hasError {
                
                ErrorView(viewModel: viewModel)
            }
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(isRoot ? .large : .inline)
        #endif
        .navigationTitle(navTitle)
        .onAppear() {
            if viewModel.path == nil { viewModel.path = path }
            try? viewModel.getDropboxContent()
        }
    }
}

struct FolderBodyView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewBody()
    }
}
