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
    @State var loadTaskHandle:Task.Handle<Void,Never>? = nil
    var body: some View {
        VStack {
            TextField("Adresse du site", text: $enteredSiteUrl)
                .textFieldStyle(.roundedBorder)
                .textContentType(UITextContentType.URL)
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
            TextField("Adresse de l'image", text: $enteredImageUrl)
                .textFieldStyle(.roundedBorder)
                .textContentType(UITextContentType.URL)
                .disableAutocorrection(true)
                .autocapitalization(UITextAutocapitalizationType.none)
            if isLoading {
                ProgressView()
                Button {
                    isLoading = false
                    loadTaskHandle?.cancel()
                } label: {
                    Label("Annuler le chargement des données", systemImage: "xmark.circle")
                }
            } else {
                Button {
                    isLoading = true
                    loadTaskHandle = async {
                        loadedText = (try? await loadDataFromPurpleGiraffe()) ?? "Erreur"
                        isLoading = false
                        if Task.isCancelled {
                            loadedText = "Annulé"
                        }
                    }
                    asyncDetached(priority:.background) {
                        await backupDataToDisk()
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
    
    func backupDataToDisk() async {
        
    }
    
    func loadDataFromTheInternet() async throws -> (String, UIImage?) {
        guard let siteUrl = URL(string: enteredSiteUrl),
              let imageUrl = URL(string: enteredImageUrl) else { return ("URL incorrecte", nil) }
        var htmlContent:String? = nil
        var imageContent:UIImage? = nil
        
        async let (siteData, _) = URLSession.shared.data(from: siteUrl)
        async let (imageData, _) = URLSession.shared.data(from: imageUrl)
        
        htmlContent = try await String(data: siteData, encoding: String.Encoding.utf8)
        imageContent = try await UIImage(data: imageData)

        return (htmlContent ?? "Aucune donnée disponible pour cette adresse", imageContent)
    }
    
    func loadDataFromPurpleGiraffe() async throws -> String {
        let urlList = ["https://www.purplegiraffe.fr",
                       "https://forum.purplegiraffe.fr",
                       "https://blog.purplegiraffe.fr",
                       "https://apps.purplegiraffe.fr"]
        var htmlContent:String = ""
        
        try await withThrowingTaskGroup(of: String.self) { group in
            for url in urlList {
                group.async {
                    return try await loadTextFrom(url: url)
                }
                for try await html in group {
                    htmlContent.append(html)
                }
            }
        }
        
   
        return htmlContent
    }
    
    func loadTextFrom(url:String) async throws -> String {
        try Task.checkCancellation()
        var loadedText:String? = nil
        if let url = URL(string: url) {
            let (htmlData, _) = try await URLSession.shared.data(from: url)
            loadedText = String(data: htmlData, encoding: String.Encoding.utf8)
        }
        return loadedText ?? "Erreur"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
