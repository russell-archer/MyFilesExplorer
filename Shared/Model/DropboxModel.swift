//
//  DropboxModel.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 18/05/2021.
//

import Foundation
import SwiftyDropbox

/// A model with singleton access via the `shared` property. Encapsulates access to a Dropbox account.
class DropboxModel: ObservableObject {
    
    /// Singleton access. Guaranteed to be lazily initialized only once, even when accessed across multiple threads simultaneously.
    static let shared = DropboxModel()

    private var dropboxClient: DropboxClient?
    
    private init() {
        
        // If we're running in Xcode as a preview then don't attempt to initialize the dropbox client (crashes preview).
        if Utils.isRunningPreview || Utils.isMocked { return }
        
        dropboxClient = DropboxClient(accessToken: "your-access-token-goes-here")
        
        #if os(iOS)
        DropboxClientsManager.setupWithAppKey("your-appkey-goes-here")
        #elseif os(macOS)
        DropboxClientsManager.setupWithAppKeyDesktop("your-appkey-goes-here")
        #endif
    }
    
    /// List the contents of the requested Dropbox path.
    /// - Parameters:
    ///   - path: Path required. Must start with a forward slash (/).If an empty string ("") is passed the contents of the root folder is returned.
    ///   - completion: A completion handler that is called when the requested data is available or an error is encountered.
    func listFolder(path: String, completion: @escaping (Result<[DropboxItem], DropboxModelError>) -> Void) {
        
        guard let client = dropboxClient else {
            listFolderMock(path: path, completion: completion)
            return
        }
        
        client.files.listFolder(path: path).response { response, error in
            
            guard error == nil else {
                completion(.failure(.dropboxError))
                return
            }
            
            guard let result = response else {
                completion(.failure(.noData))
                return
            }
            
            var folderData = [DropboxItem]()
            
            for entry in result.entries {
                switch entry {
                    case let fileMetaData as Files.FileMetadata:
                        folderData.append(DropboxItem(fileMetaData: fileMetaData))
                        
                    case let folderMetaData as Files.FolderMetadata:
                        folderData.append(DropboxItem(folderMetaData: folderMetaData))
                        
                    default: print("Unknown Dropbox object: \(entry)")
                }
            }
            
            guard folderData.count > 0 else {
                completion(.failure(.noEntries))
                return
            }
            
            completion(.success(folderData))
        }
    }
    
    func listFolderMock(path: String, completion: @escaping (Result<[DropboxItem], DropboxModelError>) -> Void) {
        
        // To use mocked data define MOCK in Build Settings > Swift Compiler - Custom Flags
        var folderData = [DropboxItem]()

        switch path {
            case "":
                folderData.append(DropboxItem(id: "0", name: "Backups", path: "/Backups", size: 0, isFile: false))
                folderData.append(DropboxItem(id: "1", name: "Sites", path: "/Sites", size: 0, isFile: false))
                folderData.append(DropboxItem(id: "2", name: "Notes", path: "/Notes", size: 0, isFile: false))
                folderData.append(DropboxItem(id: "3", name: "Documents", path: "/Documents", size: 0, isFile: false))

            case "/Documents":
                folderData.append(DropboxItem(id: "4", name: "Pages", path: "/Documents/Pages", size: 0, isFile: false))
                folderData.append(DropboxItem(id: "5", name: "Numbers", path: "/Documents/Numbers", size: 0, isFile: false))
                folderData.append(DropboxItem(id: "6", name: "Keynote", path: "/Documents/Keynote", size: 0, isFile: false))
                folderData.append(DropboxItem(id: "7", name: "Invoices", path: "/Documents/Invoices", size: 0, isFile: false))

            case "/Documents/Invoices":
                folderData.append(DropboxItem(id: "9", name: "invoice1.docx", path: "/Documents/Invoices/invoice1.docx", size: 10, isFile: true))
                folderData.append(DropboxItem(id: "10", name: "invoice2.docx", path: "/Documents/Invoices/invoice2.docx", size: 11, isFile: true))
                folderData.append(DropboxItem(id: "10", name: "invoice3.docx", path: "/Documents/Invoices/invoice3.docx", size: 12, isFile: true))
                
            default:
                folderData.append(DropboxItem(id: "12", name: "", path: "", size: 0, isFile: false))
        }
        
        completion(.success(folderData))
    }
}

