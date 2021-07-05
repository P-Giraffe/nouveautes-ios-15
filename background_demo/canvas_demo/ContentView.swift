//
//  ContentView.swift
//  canvas_demo
//
//  Created by Maxime Britto on 05/07/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: "https://www.gamereactor.fr/media/05/mythicquest_3460583_325x.jpg")!)
            Text("Nouvelle saison disponible!")
                .padding()
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        }.padding()
            .background(.purple)
            
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
