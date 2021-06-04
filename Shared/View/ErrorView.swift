//
//  ErrorView.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 25/05/2021.
//

import SwiftUI

struct ErrorView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.errorCondition.description())
                .font(.title)
                .padding()
            
            Image(systemName: "xmark.octagon")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .foregroundColor(.red)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = ViewModel()
        viewModel.hasError = true
        viewModel.errorCondition = DropboxModelError.dropboxError
        
        return ErrorView(viewModel: viewModel)
    }
}
