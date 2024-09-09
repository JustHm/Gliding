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
    struct Input { //event stream
        let refresh: Observable<Bool>
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
    
    private let urlSession: URLSession
    private let healthData: HealthData
    private let locationManager: LocationManager
    // Core Data Instance
    
    
    
    init(
        healthData: HealthData = HealthData.instance,
        urlSession: URLSession = URLSession.shared,
        locationManager: LocationManager = LocationManager()
    ) {
        self.healthData = healthData
        self.urlSession = urlSession
        self.locationManager = locationManager
        
        healthData.requestAuthorization { isChecked, error in
            if !isChecked { print(error?.localizedDescription as Any)}
            // 통계를 사용하려면 권한이 꼭 필요하다는 알림? 띄우기
        }
        if !locationManager.checkAuthorizationStatus() {
            // 위치정보 alert 띄우기
        }
        //Location, HealthData Load
        //PoolList, Tip
        
        todayRelay = BehaviorRelay(value: nil)
        poolListRelay = BehaviorRelay(value: [])
        tipListRelay = BehaviorRelay(value: [])
    }
    
    
    func transform(input: Input) -> Output {
        input.refresh.subscribe { [weak self] value in
            if value { self?.refreshData()}
        }.disposed(by: disposeBag)
        
        let today = todayRelay.asDriver(onErrorJustReturn: nil)
        let poolList = poolListRelay.asDriver(onErrorJustReturn: [])
        let swimTip = tipListRelay.asDriver(onErrorJustReturn: [])
        
        
        return Output(today: today,
                      swimTip: swimTip,
                      poolList: poolList
        )
    }
    
    private func refreshData() {
        todayRelay.accept(<#T##event: StatisticData?##StatisticData?#>)
        poolListRelay.accept(<#T##event: [PoolInfo]##[PoolInfo]#>)
        tipListRelay.accept(<#T##event: [ArticleModel]##[ArticleModel]#>)
    }
}
