//
//  RecordDetailViewModel.swift
//  Gliding
//
//  Created by 안정흠 on 9/1/25.
//

import Foundation
import Observation

@Observable
final class RecordDetailViewModel {
    @ObservationIgnored private let usecase: SwimRecordUsecase
    
//    var record: SwimRecord?
    
    
    init(usecase: SwimRecordUsecase) {
        self.usecase = usecase
    }
}
