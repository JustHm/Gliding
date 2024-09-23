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
import UIKit

final class HomeViewModel: ViewModel {
    struct Input { //event stream
        let refresh: PublishRelay<Bool>
    }
    struct Output {//result stream
        let today: Driver<StatisticData?> // 오늘 운동데이터 (간단한 정보만)
        //        let trainingList: Driver<[TrainingTableModel]> // 즐겨찾기 한 훈련표 리스트
        let swimTip: Driver<[ArticleModel]> // 수영 팁 아티클 리스트
        let poolList: Driver<[PoolInfo]> // 수영장 정보 리스트
    }
    
    private let disposeBag = DisposeBag()
    
    private let todayRelay: BehaviorRelay<StatisticData?>
    private let poolListRelay: BehaviorRelay<[PoolInfo]>
    private let tipListRelay: BehaviorRelay<[ArticleModel]>
    
//    private let urlSession: URLSession
//    private let healthData: HealthData
//    private let locationManager: LocationManager
    // Core Data Instance
    
    
    
    init(
    ) {
        //Location, HealthData Load
        //PoolList, Tip
        
        todayRelay = BehaviorRelay(value: nil)
        poolListRelay = BehaviorRelay(value: [PoolInfo(id: "1", name: "1", address: "1", website: "1", phone: "1")])
        tipListRelay = BehaviorRelay(value: [ArticleModel(title: "1", body: "1")])
    }
    
    
    func transform(input: Input) -> Output {
        input.refresh
            .filter{$0}
            .subscribe { [weak self] _ in self?.refreshData()}
            .disposed(by: disposeBag)
        
        let today = todayRelay.asDriver(onErrorJustReturn: nil)
        let poolList = poolListRelay.asDriver(onErrorJustReturn: [])
        let swimTip = tipListRelay.asDriver(onErrorJustReturn: [])
        
        
        return Output(today: today,
                      swimTip: swimTip,
                      poolList: poolList
        )
    }
    
    private func refreshData() {
        let today: StatisticData? = StatisticData(workoutDone: true, date: Date())
        let poolList: [PoolInfo] = [
            PoolInfo(id: "1", name: "1", address: "1", website: "1", phone: "1"),
            PoolInfo(id: "2", name: "1", address: "1", website: "1", phone: "1"),
            PoolInfo(id: "3", name: "1", address: "1", website: "1", phone: "1")
        ]
        let tips: [ArticleModel] = [
                ArticleModel(title: "1", body: "1"),
                ArticleModel(title: "2", body: "ㅁ"),
                ArticleModel(title: "1", body: "ㄴ"),
                ArticleModel(title: "2", body: "ㅇ"),
                ArticleModel(title: "1", body: "ㄹ"),
                ArticleModel(title: "2", body: "ㅎ"),
                ArticleModel(title: "3", body: "ㅗ")
        ]
        
        todayRelay.accept(today)
        poolListRelay.accept(poolList)
        tipListRelay.accept(tips)
    }
}
