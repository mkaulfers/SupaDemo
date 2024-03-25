//
//  Todo.swift
//  SupaDemo
//
//  Created by Matthew Kaulfers on 3/25/24.
//

import Foundation

struct Todo: Codable {
    var id: Int?
    var title: String
    var description: String
    var dueDate: Date
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case dueDate = "due_date"
        case createdAt = "created_at"
    }
}
