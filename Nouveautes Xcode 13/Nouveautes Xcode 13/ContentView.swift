//
//  ContentView.swift
//  Nouveautes Xcode 13
//
//  Created by Maxime Britto on 21/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State var enteredName:String
    @State var validatedName:String?
    var body: some View {
        if let validatedName = validatedName {
            Text(validatedName)
                .padding()
        }
        TextField("Prénom", text: $enteredName)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
