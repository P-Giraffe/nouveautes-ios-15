//
//  TodoRow.swift
//  todos
//
//  Created by Maxime Britto on 29/06/2021.
//

import SwiftUI

struct TodoRow: View {
    let status:LocalizedStringKey
    let todo:Todo
    var body: some View {
        HStack {
            if todo.isImportant {
                Image(systemName: "star")
            }
            Text(todo.title)
                .font(.headline)
                .textSelection(.enabled)
            Spacer()
            if todo.completed {
                Image(systemName: "checkmark")
            }
        }.padding()
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoRow(status: "Status", todo: Todo(id: 1, title: "A faire", completed: false, isImportant: true))
            TodoRow(status: "Status", todo: Todo(id: 2, title: "Deja fait", completed: true))
                
        }.previewLayout(.fixed(width: 600, height: 100))
    }
}
