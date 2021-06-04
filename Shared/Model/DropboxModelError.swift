//
//  DropboxModelError.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 21/05/2021.
//

import Foundation

/// An error enum used by DropboxModel.
enum DropboxModelError: Error {
    case noError, dropboxError, badPath, badAuthenticationCode, badResponse, noData, noEntries, cantGetToken, userNotAuthenticated
    
    func description() -> String {
        switch self {
            case .noError:                  return "No error."
            case .dropboxError:             return "Dropbox error. You may need to renew the access token."
            case .badPath:                  return "Invalid Dropbox path."
            case .badAuthenticationCode:    return "Dropbox supplied an invalid authentication code."
            case .badResponse:              return "Dropbox returned an invalid response."
            case .noData:                   return "Dropbox returned no data."
            case .noEntries:                return "Dropbox folder contains no entries."
            case .cantGetToken:             return "Request for Dropbox access token failed."
            case .userNotAuthenticated:     return "Dropbox user is not authenticated."
        }
    }
}

