//
//  ContentView.swift
//  taches_asynchrones
//
//  Created by Maxime Britto on 16/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State var loadedText = "Prêt"
    @State var enteredUrl = "https://www.purplegiraffe.fr"
    var body: some View {
        VStack {
            TextField("Adresse du site", text: $enteredUrl)
                .textFieldStyle(.roundedBorder)
                .textContentType(UITextContentType.URL)
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
                
            Button {
                loadedText = loadTextFromTheInternet()
            } label: {
                Label("Charger les données", systemImage: "arrow.triangle.2.circlepath.circle")
            }
            Text(loadedText)
            Spacer()
        }
        .padding()
    }
    
    func loadTextFromTheInternet() -> String {
        guard let url = URL(string: enteredUrl) else { return "URL incorrecte" }
        let htmlContent:String?
        do {
            let data = try Data(contentsOf: url)
            htmlContent = String(data: data, encoding: String.Encoding.utf8)
        } catch {
            htmlContent = nil
        }
        return htmlContent ?? "Aucune donnée disponible pour cette adresse"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
