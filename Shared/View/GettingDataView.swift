//
//  GettingDataView.swift
//  MyFilesExplorer
//
//  Created by Russell Archer on 25/05/2021.
//

import SwiftUI

struct GettingDataView: View {
    var body: some View {
        VStack {
            ProgressView()
            
            Image(systemName: "externaldrive.connected.to.line.below")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .foregroundColor(.blue)
        }
    }
}

struct GettingDataView_Previews: PreviewProvider {
    static var previews: some View {
        GettingDataView()
    }
}
