//
//  TodoItemView.swift
//  SupaDemo
//
//  Created by Matthew Kaulfers on 3/25/24.
//

import SwiftUI

struct TodoItemView: View {
    let todo: Todo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.title)
                    .font(.headline)
                Text(todo.description)
                    .font(.subheadline)
            }
            Spacer()
            Text(todo.dueDate, style: .date)
                .font(.subheadline)
        }
    }
}

#Preview {
    TodoItemView(
        todo:
            Todo(
                id: 0,
                title: "Hello",
                description: "World",
                dueDate: .now,
                createdAt: .now
            )
    )
}
