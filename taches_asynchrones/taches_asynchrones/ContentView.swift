//
//  ContentView.swift
//  taches_asynchrones
//
//  Created by Maxime Britto on 16/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State var loadedText = "Prêt"
    @State var enteredSiteUrl = "https://www.purplegiraffe.fr"
    @State var enteredImageUrl = "https://cdn.fs.teachablecdn.com/BvG1QkLgRvqB6kia04fp"
    @State var isLoading = false
    @State var loadedImage:UIImage?
    var body: some View {
        VStack {
            TextField("Adresse du site", text: $enteredSiteUrl)
                .textFieldStyle(.roundedBorder)
                .textContentType(UITextContentType.URL)
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
            TextField("Adresse du site", text: $enteredImageUrl)
                .textFieldStyle(.roundedBorder)
                .textContentType(UITextContentType.URL)
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
            if isLoading {
                ProgressView()
            } else {
                Button {
                    isLoading = true
                    async {
                        (loadedText, loadedImage) = await loadDataFromTheInternet()
                        isLoading = false
                    }
                } label: {
                    Label("Charger les données", systemImage: "arrow.triangle.2.circlepath.circle")
                }
                
            }
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                
            }
            Text(loadedText)
            Spacer()
        }
        .padding()
    }
    
    func loadDataFromTheInternet() async -> (String, UIImage?) {
        guard let siteUrl = URL(string: enteredSiteUrl),
              let imageUrl = URL(string: enteredImageUrl) else { return ("URL incorrecte", nil) }
        var htmlContent:String? = nil
        var imageContent:UIImage? = nil
        do {
            async let (siteData, _) = URLSession.shared.data(from: siteUrl, delegate: nil)
            async let (imageData, _) = URLSession.shared.data(from: imageUrl, delegate: nil)
            htmlContent = try await String(data: siteData, encoding: String.Encoding.utf8)
            imageContent = try await UIImage(data: imageData)
        } catch {
        }
        return (htmlContent ?? "Aucune donnée disponible pour cette adresse", imageContent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
