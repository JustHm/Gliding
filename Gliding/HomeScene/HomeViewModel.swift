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
    private let todayRelay: BehaviorRelay<Int>
    private let poolListRelay: BehaviorRelay<Int>
    private let tipListRelay: BehaviorRelay<Int>
    private let trainingListRelay: BehaviorRelay<Int>
    
    private let urlSession: URLSession
    private let healthData: HealthData
    
    struct Input {
        let refresh: PublishRelay<Void>
        let trainingDetail: PublishRelay<Int> // Int -> ID
        let poolListDetail: PublishRelay<String> // road address
        let tipDetail: PublishRelay<String> //
    }
    struct Output {
        let today: Driver<Int> // 오늘 운동 현황 데이터
        let swimTip: Driver<Int> // 수영 팁 아티클 리스트
        let trainingList: Driver<Int> // 훈련표 리스트
        let poolList: Driver<Int> // 수영장 정보 리스트
        
    }
    
    init(
        healthData: HealthData = HealthData.instance,
        urlSession: URLSession = URLSession.shared
    ) {
        self.healthData = healthData
        self.urlSession = urlSession
    }
    
    
    func transform(input: Input) -> Output {
        
        
    }
    
}
