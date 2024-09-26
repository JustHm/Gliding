//
//  TrainingListViewModel.swift
//  Gliding
//
//  Created by 안정흠 on 9/25/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class TrainingListViewModel: ViewModel {
    var sampleData: [TrainingTableModel] = [
        TrainingTableModel(id: UUID(), title: "Test1", detail: "Test detail", warmUpSet: [], mainSet: [], coolDownSet: []),
        TrainingTableModel(id: UUID(), title: "Test2", detail: "Test detail", warmUpSet: [], mainSet: [], coolDownSet: []),
        TrainingTableModel(id: UUID(), title: "Test3", detail: "Test detail", warmUpSet: [], mainSet: [], coolDownSet: []),
        TrainingTableModel(id: UUID(), title: "Test4", detail: "Test detail", warmUpSet: [], mainSet: [], coolDownSet: [])
    ]
    struct Input {
        let deleted: PublishRelay<UUID>
        let searchFromTitle: PublishRelay<String>
//        let addTrainingTable: PublishRelay<Void>
    }
    struct Output {
        let trainingList: Driver<[TrainingTableModel]>
    }
    private let disposeBag: DisposeBag = DisposeBag()
    private let listRelay: BehaviorRelay<[TrainingTableModel]>
    
    init() {
        //core data load
        listRelay = BehaviorRelay<[TrainingTableModel]>(value: sampleData)
    }
    
    
    func transform(input: Input) -> Output {
        input.deleted.subscribe { [weak self] value in
            self?.deleteItem(id: value)
        }
        .disposed(by: disposeBag)
        
        input.searchFromTitle
            .filter { $0 != "" }
            .subscribe { [weak self] value in
                self?.searchingWithTitleFromList(query: value)
            }
            .disposed(by: disposeBag)
        
        let list = listRelay.asDriver(onErrorJustReturn: [])
        return Output(trainingList: list)
    }
    
    private func fetchTrainingList() {
        listRelay.accept(sampleData.shuffled())
    }
    
    private func searchingWithTitleFromList(query: String) {
        
    }
    
    private func deleteItem(id: UUID) {
        
    }
}
