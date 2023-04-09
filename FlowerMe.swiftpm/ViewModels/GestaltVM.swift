//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/06.
//

import SwiftUI
import Combine

final class GestaltVM: ObservableObject {
    @Published var clearedPrinciples = [String]()
    
    @Published var isFirstDisplayedClosure: Bool = false
    @Published var isFirstDisplayedContinuation: Bool = false
    @Published var isFirstDisplayedFigrueGround: Bool = false
    @Published var isFirstDisplayedProximity: Bool = false
    @Published var isFirstDisplayedSimilarity: Bool = false
    @Published var isFirstDisplayedPragnanz: Bool = false
    
    // 4 True == Clear
    @Published var closurePuzzle: [Bool] = []
    @Published var closurePuzzleCleared: Bool = false
    
    // Tap to Clear
    @Published var proximityPuzzleCleared: Bool = false
    
    // badge Counts
    @Published var dispalyBadgesCount: Int = 0
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addClosurePuzzleSubscriber()
        addBadgeCountSubscriber()
    }
    
    /**
     내부의 Published 결과 리스트가 변화할 때마다 receiveValue를 확인하고 조건에 따라 특정 속성을 재할당합니다.
     */
    private func addClosurePuzzleSubscriber() {
        self.$closurePuzzle
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { [weak self] results in
                print(results)
                if results.count == 4 {
                    self?.closurePuzzleCleared = true
                }
            }
            .store(in: &cancellables)
    }
    
    private func addBadgeCountSubscriber() {
        self.$clearedPrinciples
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            } receiveValue: { [weak self] results in
                // 클리어한 내용이 추가될 때마다 뱃지 숫자는 하나씩 늘어난다.
                // 그후, 뱃지 탭을 들어갈 때마다 모델 밖에서 뱃지 카운트를 0으로 초기화한다.
                if !results.isEmpty {
                    self?.dispalyBadgesCount += 1
                }
            }
            .store(in: &cancellables)
    }
}
