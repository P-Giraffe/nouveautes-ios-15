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
            ForEach($todoList) { $todo in
                TodoRow(todo: todo).onTapGesture {
                    todo.completed.toggle()
                }.swipeActions(allowsFullSwipe:false) {
 
                    Button(role: .destructive) {
                        if let index = todoList.firstIndex(of: todo) {
                            withAnimation {
                                _ = todoList.remove(at: index)
                            }
                        }
                    } label: {
                        Label("Supprimer", systemImage: "trash")
                    }
                }.swipeActions(edge: .leading) {
                    Button {
                        todo.isImportant.toggle()
                    } label: {
                        Label("Important", systemImage: "star")
                    }
                }
                    
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
