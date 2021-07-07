//
//  ContentView.swift
//  formatters-demo
//
//  Created by Maxime Britto on 05/07/2021.
//

import SwiftUI

struct ContentView: View {
    @State var date = Date()
    @State var price = 12.45
    var body: some View {
        VStack {
            Text(date.formatted(.dateTime.day().month(.defaultDigits).hour().minute()))
            Text(price.formatted(.currency(code: "USD")))
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().environment(\.locale, .init(identifier: "fr"))
            ContentView().environment(\.locale, .init(identifier: "en"))
        }.previewLayout(.sizeThatFits)
    }
}
