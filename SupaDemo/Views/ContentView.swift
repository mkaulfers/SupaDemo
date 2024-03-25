//
//  ContentView.swift
//  SupaDemo
//
//  Created by Matthew Kaulfers on 3/25/24.
//

import SwiftUI

struct ContentView: View {
    let manager = SupaManager.shared
    
    @State var todos: [Todo] = []
    @State var addNewTodo = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos, id: \.id) { todo in
                    TodoItemView(todo: todo)
                }
                
                .onDelete { indexSet in
                    for index in indexSet {
                        deleteTodo(todos[index])
                    }
                }
            }
            .refreshable {
                onAppearTask()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    toolbarItem
                }
            }
            .sheet(isPresented: $addNewTodo) {
                CreateTodoView()
            }
            .onAppear(perform: onAppearTask)
        }
    }
    
    var toolbarItem: some View {
        Button(action: { addNewTodo.toggle() } ) {
            Image(systemName: "plus")
        }
    }
    
    func onAppearTask() {
        Task {
            do {
                todos = try await manager.getTodos()
            } catch(let error) {
                print(error)
            }
        }
    }
    
    func deleteTodo(_ todo: Todo) {
        Task {
            do {
                try await manager.deleteTodo(todo.id!)
            } catch(let error) {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
}
