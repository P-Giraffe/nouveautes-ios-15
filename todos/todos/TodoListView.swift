//
//  ContentView.swift
//  todos
//
//  Created by Maxime Britto on 29/06/2021.
//

import SwiftUI

struct TodoListView: View {
    @State var todoList:[Todo] = []
    var body: some View {
        List {
            ForEach(todoList) { todo in
                TodoRow(todo: todo)
            }
        }
        .task {
            await loadTodoList()
        }
        .refreshable {
            await loadTodoList()
        }
    }
    
    func loadTodoList() async  {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        do {
            let (response, _) = try await URLSession.shared.data(from: url)
            todoList = try JSONDecoder().decode([Todo].self, from: response)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
