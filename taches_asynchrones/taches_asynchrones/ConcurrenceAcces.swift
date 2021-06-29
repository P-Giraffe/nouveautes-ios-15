//
//  ConcurrenceAcces.swift
//  taches_asynchrones
//
//  Created by Maxime Britto on 24/06/2021.
//

import SwiftUI

struct ConcurrenceAcces: View {
    @StateObject var viewModel = MonViewModel()
    var body: some View {
        VStack {
            Text("Valeur \(viewModel.displayedValue)")
            if let imageURL = URL(string: "https://premiere.fr/sites/default/files/styles/scale_crop_1280x720/public/2021-04/MQU2_Special-Episode-vertical-1280x720.png") {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
            }
            
            
        }.task {
            await viewModel.loadData()
        }
    }

}



struct ConcurrenceAcces_Previews: PreviewProvider {
    static var previews: some View {
        ConcurrenceAcces()
    }
}
