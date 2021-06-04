//
//  FileDetails.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 30/05/2021.
//

import SwiftUI

struct FileDetails: View {
    
    var fileDetails: DropboxItem
    
    var body: some View {
        Form {
            Text(fileDetails.name).font(.headline)
            Text(fileDetails.path).font(.headline)
            Text("\(String(fileDetails.size)) bytes").font(.headline)
        }
        .navigationTitle("File Details")
//        .navigationBarTitleDisplayMode(.large)
    }
}

struct FileDetails_Previews: PreviewProvider {
    static var previews: some View {
        let details = DropboxItem(id: "10", name: "invoice3.docx", path: "/Documents/Invoices/invoice3.docx", size: 12, isFile: true)
        FileDetails(fileDetails: details)
    }
}
