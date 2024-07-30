//
//  ViewModel.swift
//  Gliding
//
//  Created by 안정흠 on 7/18/24.
//

protocol ViewModel: AnyObject {
    // 입력과 출력을 정의하는 연관 타입
    associatedtype Input
    associatedtype Output
    
    // 입력을 받아 출력을 생성하는 메서드
    func transform(input: Input) -> Output
}
