
// generally avoid testing implementation, test behavior instead
// @MainActor is a requirement for TCA testing

import ComposableArchitecture
@testable import RPSTCA
import XCTest

@MainActor
final class RPSTCATests: XCTestCase {

    func test_gameOverDisablesHandChoiceButtons_rock() async {
        let store = TestStore(initialState: Application.State.init(), reducer: { Application(randomHand: { .rock }) })
        await store.send(.playerHandTapped(.paper)) {
            $0.playerHand = .paper
        }
        await store.send(.goButtonTapped) {
            $0.gameOver = true
            $0.cpuHand = .rock
        }
        await store.send(.playerHandTapped(.rock))
    }
    
    func test_gameOverDisablesHandChoiceButtons_paper() async {
        let store = TestStore(initialState: Application.State.init(), reducer: { Application(randomHand: { .rock }) })
        await store.send(.playerHandTapped(.rock)) {
            $0.playerHand = .rock
        }
        await store.send(.goButtonTapped) {
            $0.gameOver = true
            $0.cpuHand = .rock
        }
        await store.send(.playerHandTapped(.paper))
    }
    
    func test_gameOverDisablesHandChoiceButtons_scissors() async {
        let store = TestStore(initialState: Application.State.init(), reducer: { Application(randomHand: { .rock }) })
        await store.send(.playerHandTapped(.scissors)) {
            $0.playerHand = .scissors
        }
        await store.send(.goButtonTapped) {
            $0.gameOver = true
            $0.cpuHand = .rock
        }
        await store.send(.playerHandTapped(.paper))
    }

}
