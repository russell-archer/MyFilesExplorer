//
//  ModelFile.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 20/05/2021.
//

import Foundation
import SwiftyDropbox

/// An object that represents an item in a Dropbox folder. It can be either a file or folder. See `isFile`.
struct DropboxItem: Hashable {
    
    let id: String
    let name: String
    let path: String
    let size: UInt64
    let isFile: Bool
    
    init(id: String, name: String, path: String?, size: UInt64, isFile: Bool) {
        self.id = id
        self.name = name
        self.path = path ?? ""
        self.size = size
        self.isFile = isFile
    }
    
    init(fileMetaData: Files.FileMetadata) {
        self.init(id: fileMetaData.id, name: fileMetaData.name, path: fileMetaData.pathDisplay, size: fileMetaData.size, isFile: true)
    }
    
    init(folderMetaData: Files.FolderMetadata) {
        self.init(id: folderMetaData.id, name: folderMetaData.name, path: folderMetaData.pathDisplay, size: 0, isFile: false)
    }
    
    func description() -> String {
        "\(id), name: \(name), path: \(path), size: \(size), isFile: \(isFile)"
    }
}
