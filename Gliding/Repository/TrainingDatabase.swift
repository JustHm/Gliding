//
//  TrainingDatabase.swift
//  Gliding
//
//  Created by 안정흠 on 7/31/24.
//

import Foundation
import CoreData

// 유저가 가지고 있는 훈련표를 (공유받은 것 포함) 로컬 데이터베이스에 저장
// **로그인 시 데이터 유저 테이블에 같이 저장**
class TrainingDatabase {
    static let instance: TrainingDatabase = TrainingDatabase()
    //CoreData Init
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SongModel")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    init() {
        
    }
    
    func fetchTrainingData() async throws -> [TrainingTableModel]{
        return []
    }
    
    func addTrainingData(_ table: TrainingTableModel) async throws  -> Bool {
        return true
    }
    
    func removeTrainingData(_ table: Int...) async throws  -> Bool {
        return true
    }
}
