//
//  ContentView.swift
//  focus_demo
//
//  Created by Maxime Britto on 05/07/2021.
//

import SwiftUI

struct ContentView: View {
    enum Field : Int, Hashable, CaseIterable {
        case email
        case password
    }
    @State var email = ""
    @State var  password = ""
    @FocusState var focusedField:Field?
    
    var body: some View {
        Form {
            TextField("Username", text: $email)
                .focused($focusedField, equals: .email)

            SecureField("Password", text: $password)
                .focused($focusedField, equals: .password)

            Button("Sign In") {
                if email.isEmpty {
                    focusedField = .email
                } else if password.isEmpty {
                    focusedField = .password
                } else {
                    print("LOGIN")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
