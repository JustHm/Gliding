//
//  SwiftDataRepository.swift
//  Gliding
//
//  Created by 안정흠 on 7/25/25.
//

import Foundation
import SwiftData

protocol SwiftDataRepository {
    associatedtype T: PersistentModel
    
    func insertData(data: T) async throws
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async throws
    func fetchData(where predicate: Predicate<T>?, sort: [SortDescriptor<T>]) async throws -> [T]
    func deleteData(where predicate: Predicate<T>) async throws
    func deleteAll() async throws
}

@ModelActor
final actor SwiftDataRepositoryImpl<T: PersistentModel>: SwiftDataRepository {
    
//    init(modelContainer: ModelContainer) {
//        self.init(modelContainer: modelContainer)
//    }
    func insertData(data: T) async throws {
        
    }
    
    func updateData(predicate: Predicate<T>, updateBlock: @escaping (T) -> Void) async throws {
        
    }
    
    func fetchData(where predicate: Predicate<T>?, sort: [SortDescriptor<T>]) async throws -> [T] {
        []
    }
    
    func deleteData(where predicate: Predicate<T>) async throws {
        
    }
    
    func deleteAll() async throws {
        
    }
}
