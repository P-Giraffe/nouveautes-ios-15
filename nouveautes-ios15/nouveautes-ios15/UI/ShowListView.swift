//
//  ContentView.swift
//  nouveautes-ios15
//
//  Created by Maxime Britto on 15/06/2021.
//

import SwiftUI

struct ShowListView: View {
    @StateObject var showManager = ShowManager()
    @State var addNewShow = false
    var body: some View {
        
        NavigationView {
            List {
                ForEach (showManager.showList, id:\.name) { show in
                    Text(show.name)
                }
                
            }
        }.navigationBarHidden(false)
        .navigationBarItems(trailing: Button {
            addNewShow = true
        } label: {
            Label("Ajouter", systemImage: "add")
        })
            .popover(isPresented: $addNewShow) {
            AddNewShowView(stayVisible: $addNewShow)
        }.task {
            async {
                await showManager.loadShows()
            }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ShowListView()
    }
}
