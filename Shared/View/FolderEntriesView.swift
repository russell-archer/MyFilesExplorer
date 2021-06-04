//
//  FolderEntriesView.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 25/05/2021.
//

import SwiftUI

struct FolderEntriesView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {

        List {
            ForEach(viewModel.folderContent, id: \.self) { entry in
                if entry.isFile {
                    
                    NavigationLink(destination: FileDetails(fileDetails: entry)) {
                        
                        Text(entry.name)
                            .font(.title)
                            .padding()
                    }
                    
                } else {
                    
                    NavigationLink(destination: ContentView(path: "\(viewModel.path!)/\(entry.name)")) {
                        HStack {
                            Image(systemName: "folder")
                                .resizable()
                                .frame(width: 30)
                                .padding()
                                .foregroundColor(.blue)
                            
                            Text(entry.name)
                                .font(.title)
                                .padding()
                        }
                    }
                }
            }
        }
    }
}

struct FolderEntriesView_Previews: PreviewProvider {
    static var previews: some View {
        
        FolderEntriesView(viewModel: ViewModel())
    }
}
