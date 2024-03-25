//
//  SupaManager.swift
//  SupaDemo
//
//  Created by Matthew Kaulfers on 3/25/24.
//

import Foundation
import Supabase

struct SupaManager {
    static let shared = SupaManager()
    private let client = SupabaseClient(
        supabaseURL: URL(string: "<yourURL>")!,
        supabaseKey: "<yourKey>"
    )
        
    func createTodo(_ todo: Todo) async throws {
        try await client.database
            .from("todos")
            .insert(todo)
            .execute()
    }
    
    func upsertTodo(_ todo: Todo) async throws {
        try await client.database
            .from("todos")
            .upsert(todo)
            .execute()
    }
    
    func readTodo(_ id: Int) async throws -> Todo {
        
        // This is smart enough to recognize, with the .value property
        // that the response is a Todo object. It's also aware of the
        // Codable implementation (Eg Encodable, or Decodable)
        
        let response: Todo = try await client.database
            .from("todos")
            .select("id")
            .eq("id", value: id)
            .single()
            .execute()
            .value
        
        return response
    }
    
    func getTodos() async throws -> [Todo] {
        let response: [Todo] = try await client.database
            .from("todos")
            .select()
            .execute()
            .value
        
        return response
    }

    
    func updateTodo(_ todo: Todo) async throws {
        try await client.database
            .from("todos")
            .update(todo)
            .execute()
    }
    
    func deleteTodo(_ id: Int) async throws {
        try await client.database
            .from("todos")
            .delete()
            .eq("id", value: id)
            .execute()
    }
}
