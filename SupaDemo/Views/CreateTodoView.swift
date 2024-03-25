//
//  CreateTodoView.swift
//  SupaDemo
//
//  Created by Matthew Kaulfers on 3/25/24.
//

import SwiftUI

struct CreateTodoView: View {
    let database = SupaManager.shared
    
    @Environment(\.dismiss) var dismiss
    
    @State var title = ""
    @State var description = ""
    @State var dueDate: Date = .now
    
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
            
            TextField("Description", text: $description)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
            
            DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding()
            
            Button(action: createTodo) {
                Text("Create Todo")
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .foregroundColor(.white)
            }
            .padding()
        }
    }
    
    func createTodo() {
        Task {
            do {
                let todo = Todo(
                    title: title,
                    description: description,
                    dueDate: dueDate
                )
                
                try await database.createTodo(todo)
                dismiss()
            } catch(let error) {
                print(error)
            }
        }
    }
}

#Preview {
    CreateTodoView()
}
