//
//  TrainingDetailViewModel.swift
//  Gliding
//
//  Created by 안정흠 on 9/27/24.
//

import RxSwift
import RxCocoa

final class TrainingDetailViewModel: ViewModel {
    struct Input {
        let isEdit: PublishSubject<Bool>
    }
    struct Output {
//        let tableData: Driver<TrainingTableModel>
        //
    }
    
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        return Output(
        )
    }
}
