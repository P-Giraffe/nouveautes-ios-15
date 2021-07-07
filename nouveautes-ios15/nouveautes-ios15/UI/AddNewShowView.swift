//
//  AddNewShowView.swift
//  nouveautes-ios15
//
//  Created by Maxime Britto on 16/06/2021.
//

import SwiftUI

struct AddNewShowView: View {
    @Binding var stayVisible:Bool
    @State var enteredName:String = ""
    @State var enteredYear:String = ""
    var body: some View {
        VStack {
            Text("Nouvelle Série")
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0))
            TextField("Titre", text: $enteredName)
                .textFieldStyle(.roundedBorder)
            TextField("Année", text: $enteredYear)
                .textFieldStyle(.roundedBorder)
            Button {
                if let year = Int(enteredYear),
                   enteredName.isEmpty == false,
                   year > 0 {
                    async {
                        let showManager = ShowManager()
                        _ = await showManager.addShow(name: enteredName, year: year)
                        stayVisible = false
                    }
                }
                
            } label: {
                Label("Ajouter", systemImage: "plus")
            }.buttonStyle(.bordered)

        }.padding()
    }
}

struct AddNewShowView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewShowView(stayVisible: .constant(true))
    }
}
