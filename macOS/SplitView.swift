//
//  ContentView.swift
//  MyFilesExplorer (macOS)
//
//  Created by Russell Archer on 31/05/2021.
//

import SwiftUI

struct SplitView: View {
    
    @State var selected: Int? = nil
    
    var body: some View {
        HStack {
            List(0...10, id: \.self, selection: $selected) { number in
                HStack {
                    Text("Select \(number)")
                    Spacer()
                }
                .background((selected == number ? highlightColor : nil).offset(x: -10, y: 0))
                .contentShape(Rectangle())
                .onTapGesture {
                    selected = number
                }
            }
            .frame(width: 200)
            .listStyle(SidebarListStyle())
            
            Spacer()
            detailView
            Spacer()
        }
        
    }
    
    @ViewBuilder var detailView: some View {
        if selected == nil {
            Text("Nothing is selected")
        } else {
            Text("\(selected!) is selected")
        }
    }

    var highlightColor: some View {
        Color.accentColor
            .opacity(0.8)
            .cornerRadius(10)
            .frame(height: 40)
            .frame(minWidth: 150, maxWidth: 200)
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
