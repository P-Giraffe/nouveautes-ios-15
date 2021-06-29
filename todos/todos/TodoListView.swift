//
//  ContentView.swift
//  todos
//
//  Created by Maxime Britto on 29/06/2021.
//

import SwiftUI

struct TodoListView: View {
    @State var todoList:[Todo] = []
    @State var searchFilter = ""
    var body: some View {
        NavigationView {
            List {
                ForEach($todoList) { $todo in
                    if searchFilter.isEmpty || todo.title.lowercased().contains(searchFilter.lowercased()) {
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
                        }.listRowSeparator(.hidden)
                    }
                }
            }
            .navigationTitle("Todos")
            .task {
                await loadTodoList()
            }
            .refreshable {
                await loadTodoList()
            }
            .searchable(text: $searchFilter) {
                switch searchFilter.count {
                case 0:
                    Text("🚀").searchCompletion("fusée")
                    Text("☀️").searchCompletion("soleil")
                case 1:
                    Text("🏝").searchCompletion("île")
                    Text("🐴").searchCompletion("porro")
                default:
                    Text("✅").searchCompletion("ok")
                }
            }
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
