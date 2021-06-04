//
//  ViewModel.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 21/05/2021.
//

import SwiftUI

/// A ViewModel that publishes data retrieved from DropboxModel. Each View will have its own ViewModel.
class ViewModel: ObservableObject {
    
    @Published var folderContent = [DropboxItem]()      /// The contents of the current Dropbox folder.
    @Published var gettingData = false                  /// True if we're getting data from Dropbox
    @Published var hasError = false                     /// True if we have an error condition
    
    var hasContent: Bool { folderContent.count > 0 }    /// True if we have Dropbox content, false otherwise.
    var path: String?                                   /// The Dropbox path for our view. Should be set by the View. Will be "" for the root folder
    var errorCondition: DropboxModelError = .noError    /// The last error we encountered
    
    /// Get the contents of the Dropbox folder indicated by the `path` property. Throws DropboxModelError.badPath if `path` is nil.
    func getDropboxContent() throws {
        
        if path == nil { throw DropboxModelError.badPath }
        
        gettingData = true
        
        DropboxModel.shared.listFolder(path: path!) { [unowned self] result in
            
            gettingData = false
            
            switch result {
                case .failure(let error):
                    errorCondition = error
                    hasError = true
                    
                case .success(let data):
                    errorCondition = .noError
                    hasError = false
                    folderContent = data
            }
        }
    }
}
