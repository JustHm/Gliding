//
//  HomeViewModel.swift
//  Gliding
//
//  Created by 안정흠 on 7/18/24.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

final class HomeViewModel: ViewModel {
    private let disposeBag = DisposeBag()
    
    private let todayRelay: BehaviorRelay<Int>
    private let poolListRelay: BehaviorRelay<[PoolInfo]>
    private let tipListRelay: BehaviorRelay<[ArticleModel]>
    private let trainingListRelay: BehaviorRelay<[TrainingTableModel]>
//    private let errorRelay: PublishRelay<Error>()
    
    private let urlSession: URLSession
    private let healthData: HealthData
    
    struct Input { //event stream
        let refresh: PublishRelay<Void>
        let trainingDetail: PublishRelay<Int> // Int -> ID
        let locationRefresh: PublishRelay<Void> // pool list refresh
        let tipDetail: PublishRelay<String> //
    }
    struct Output {//result stream
        let today: Driver<Int> // 오늘 운동 현황 데이터 (meter)
        let swimTip: Driver<[ArticleModel]> // 수영 팁 아티클 리스트
        let trainingList: Driver<[TrainingTableModel]> // 훈련표 리스트
        let poolList: Driver<[PoolInfo]> // 수영장 정보 리스트
//        let error: Driver<Error>
    }
    
    init(
        healthData: HealthData = HealthData.instance,
        urlSession: URLSession = URLSession.shared
    ) {
        self.healthData = healthData
        self.urlSession = urlSession
        
        //Location, HealthData Load
        //PoolList, Tip
        
        todayRelay = BehaviorRelay(value: 0)
        poolListRelay = BehaviorRelay(value: [])
        tipListRelay = BehaviorRelay(value: [])
        trainingListRelay = BehaviorRelay(value: [])
    }
    
    
    func transform(input: Input) -> Output {
        todayRelay.subscribe { [weak self] value in
            
        }.disposed(by: disposeBag)
        
    }
    
}
