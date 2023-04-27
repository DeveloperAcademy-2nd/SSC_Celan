//
//  SwiftUIView.swift
//  
//
//  Created by Celan on 2023/04/06.
//

import SwiftUI
import Combine

final class GestaltVM: ObservableObject {
    var id = UUID().uuidString
    @Published var clearedPrinciples = [String]()
    
    @Published var isFirstDisplayedClosure: Bool = false
    @Published var isFirstDisplayedContinuity: Bool = false
    @Published var isFirstDisplayedFigrueGround: Bool = false
    @Published var isFirstDisplayedProximity: Bool = false
    @Published var isFirstDisplayedSimilarity: Bool = false
    @Published var isFirstDisplayedPragnanz: Bool = false
    
    // Tap, 4 True == Clear
    @Published var closurePuzzle: [Bool] = []
    @Published var isClosurePuzzleDone: Bool = false
    @Published var closurePuzzleCleared: Bool = false
    
    // Tap to Clear
    @Published var proximityPuzzleCleared: Bool = false
    
    // Drag to Clear
    @Published var continuityPuzzleCleared: Bool = false
    
    // Long Press to Clear
    // MARK: - Similarity
    @Published var similarityPuzzleCleared: Bool = false
    @Published var sectionA = [Int]()
    @Published var circleOpacityA: CGFloat = 1.0
    @Published var sectionB = [Int]()
    @Published var circleOpacityB: CGFloat = 1.0
    @Published var sectionC = [Int]()
    @Published var circleOpacityC: CGFloat = 1.0
    @Published var sectionD = [Int]()
    @Published var circleOpacityD: CGFloat = 1.0
    
    @Published var section1 = [Int]()
    @Published var circleOpacity1: CGFloat = 1.0
    @Published var section2 = [Int]()
    @Published var circleOpacity2: CGFloat = 1.0
    @Published var section3 = [Int]()
    @Published var circleOpacity3: CGFloat = 1.0
    @Published var section4 = [Int]()
    @Published var circleOpacity4: CGFloat = 1.0
    
    // Slide to Clear
    @Published var pragnanzPuzzleCleared: Bool = false
    
    // Long Press to Clear
    @Published var figureGroundPuzzleCleared: Bool = false
    @Published var backgroundPetalList: [Int] = (0..<30).map { $0 }
    
    // Manually Notify the changes to the view
    var backgroundBlurIntensity: CurrentValueSubject<CGFloat, Never> = .init(10)
    
    // badge Counts
    @Published var dispalyBadgesCount: Int = 0
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        addClosurePuzzleSubscriber()
        addBadgeCountSubscriber()
        sectionMaker()
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
                if results.count == 4 {
                    self?.isClosurePuzzleDone = true
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

// MARK: - GESTALT - CONTINUITY
extension GestaltVM {
    var path: Path {
        let wid = Constants.CurveCGFloat.CURVE_WIDTH
        let hei = Constants.CurveCGFloat.CURVE_HEIGHT
        var res = Path()
        res.move(to: .zero)
        
        res.addCurve(
            to: CGPoint(x: wid, y: hei),
            control1: CGPoint(x: 0, y: hei * 0.25),
            control2: CGPoint(x: wid * 1.5, y: hei * 0.75)
        )
        
        return res
    }
    
    var pathReversed: Path {
        let wid = Constants.CurveCGFloat.CURVE_WIDTH
        let hei = Constants.CurveCGFloat.CURVE_HEIGHT
        var res = Path()
        res.move(to: CGPoint(x: -wid, y: hei))
        
        res.addCurve(
            to: .zero,
            control1: CGPoint(x: -(wid * 1.5), y: hei * 0.75),
            control2: CGPoint(x: 0, y: hei * 0.25)
        )
       
        return res
    }
    
    var startReversed: CGPoint {
        CGPoint(
            x: -(Constants.CurveCGFloat.CURVE_WIDTH),
            y: Constants.CurveCGFloat.CURVE_HEIGHT
        )
    }
    
    var duration: Double { 0.5 }
}

/** SIMILARITY */
extension GestaltVM {
    
    /**
     opacity 조절을 위한 total 계산속성
     */
    public var totalOpacity: CGFloat {
        circleOpacity1 + circleOpacity2 + circleOpacity3 + circleOpacity4 +
        circleOpacityA + circleOpacityB + circleOpacityC + circleOpacityD
    }
    
    private func sectionMaker() {
        var firstSection = (0...32).map { $0 } // 33
        var secondSeection = (32...63).map { $0 } // 31
        
        for index in 0..<4 {
            switch index {
            case 0:
                appendEachSection(in: &sectionA, from: &firstSection)
            case 1:
                appendEachSection(in: &sectionB, from: &firstSection)
            case 2:
                appendEachSection(in: &sectionC, from: &firstSection)
            case 3:
                appendEachSection(in: &sectionD, from: &firstSection)
            default:
                break
            }
        }
        
        for index in 0..<4 {
            switch index {
            case 0:
                appendEachSection(in: &section1, from: &secondSeection)
            case 1:
                appendEachSection(in: &section2, from: &secondSeection)
            case 2:
                appendEachSection(in: &section3, from: &secondSeection)
            case 3:
                appendEachSection(in: &section4, from: &secondSeection)
            default:
                break
            }
        }
    }
    
    private func appendEachSection(
        in arr: inout [Int],
        from arr2: inout [Int]
    ) {
        for _ in 0..<8 {
            arr.append(
                arr2.remove(
                    at: arr2.firstIndex(
                        of: arr2.randomElement() ?? 0
                    ) ?? 0
                )
            )
        }
    }
}
