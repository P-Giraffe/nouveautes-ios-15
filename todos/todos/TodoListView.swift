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
    @State var fastMode = false
    @State var newTaskName = ""
    @State var wantsToEmptyList = false
    @FocusState var shouldFocusOnAddTodoField:Bool
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button("A TRADUIRE") {
                        print("action traduite")
                    }
                    Toggle(isOn: $fastMode) {
                        Label {
                            Text("Nouvelle tâche")
                        } icon: {
                            Image(systemName: "plus")
                                .symbolRenderingMode(.multicolor)
                                .foregroundStyle(.brown)
                                
                        }
                        
                    }
                    .padding()
                    .toggleStyle(.button)
                    Button(role: .destructive) {
                        wantsToEmptyList = true
                    } label: {
                        Label("Vider la liste", systemImage: "trash")
                        
                    }.confirmationDialog("Vider la liste", isPresented: $wantsToEmptyList) {
                        Button(role: .destructive) {
                            todoList.removeAll()
                        } label: {
                            Label("Effacer toutes les tâches", systemImage: "trash")
                        }
                    } message: {
                        Text("Vider cette liste va effacer toutes vos tâches définitivement. Êtes vous certain ?")
                    }
                    
                    
                    
                }
                if fastMode {
                    Text("Utilisez le champ ci-dessous pour ajouter vos *tâches* à la liste. Plus d'infos sur [notre site](https://www.purplegiraffe.fr)").padding()
                    TextField("Nouvelle tâche", text: $newTaskName)
                        .padding()
                        .onSubmit {
                            withAnimation {
                                todoList.insert(Todo(id: Int.random(in: 201...9999), title: newTaskName, completed: false), at: 0)
                            }
                            newTaskName = ""
                            shouldFocusOnAddTodoField = true
                        }
                        .submitLabel(.done)
                        .focused($shouldFocusOnAddTodoField)
                }
                List {
                    ForEach($todoList) { $todo in
                        if searchFilter.isEmpty || todo.title.lowercased().contains(searchFilter.lowercased()) {
                            TodoRow(status:"Status tâche", todo: todo).onTapGesture {
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
                .navigationBarItems(trailing:
                                        Button(action: {
                    fastMode = true
                    shouldFocusOnAddTodoField = false
                }, label: {
                    Label("Ajouter", systemImage: "plus")
                }).buttonStyle(.bordered)
                    .controlProminence(.increased)
                    .controlSize(.large)
                )
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
                }.onSubmit(of: .search) {
                    
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
