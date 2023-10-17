
import ComposableArchitecture
import SwiftUI

struct Application { }

extension Application: Reducer {
    struct State: Equatable {
        var playerHand: Hand = .hidden
        var cpuHand: Hand = .hidden
        var gameOver = false
    }
    
    enum Action: Equatable {
        case rockButtonTapped
        case paperButtonTapped
        case scissorsButtonTapped
        case goButtonTapped
        case resetButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .rockButtonTapped:
                state.playerHand = .rock
                return .none
            case .paperButtonTapped:
                state.playerHand = .paper
                return .none
            case .scissorsButtonTapped:
                state.playerHand = .scissors
                return .none
            case .goButtonTapped:
                state.cpuHand = randomHand()
                state.gameOver = true
                return .none
            case .resetButtonTapped:
                state.gameOver = false
                state.cpuHand = .hidden
                state.playerHand = .hidden
                return .none
            }
        }
    }
}

enum Hand: String {
    case rock = "✊"
    case paper = "✋"
    case scissors = "✌️"
    case hidden = "?"
}

func randomHand() -> Hand {
    let hands: [Hand] = [.rock, .paper, .scissors]
    return hands.randomElement()!
}

struct ContentView: View {
    let store: StoreOf<Application>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack {
                Text("Rock Paper Scissors")
                    .font(.title2.bold())
                Spacer()
                HStack {
                    VStack {
                        Text("Player")
                        Text(viewStore.playerHand.rawValue).font(.largeTitle)
                    }
                    Text("vs")
                    VStack {
                        Text("CPU")
                        Text(viewStore.cpuHand.rawValue).font(.largeTitle)
                    }
                }
                Spacer()
                Text("And the winner is...")
                
                if viewStore.gameOver {
                    if viewStore.playerHand == .rock && viewStore.cpuHand == .paper {
                        Text("CPU")
                    } else if viewStore.playerHand == .paper && viewStore.cpuHand == .scissors {
                        Text("CPU")
                    } else if viewStore.playerHand == .scissors && viewStore.cpuHand == .rock {
                        Text("CPU")
                    } else if viewStore.playerHand == .rock && viewStore.cpuHand == .scissors {
                        Text("Player")
                    } else if viewStore.playerHand == .paper && viewStore.cpuHand == .rock {
                        Text("Player")
                    } else if viewStore.playerHand == .scissors && viewStore.cpuHand == .paper {
                        Text("Player")
                    } else if viewStore.playerHand == viewStore.cpuHand {
                        Text("Tie")
                    }
                } else {
                    Text("???")
                }
                
                Spacer()
                Text("Choose your hand:")
                HStack {
                    if viewStore.playerHand == .rock {
                        Button("✊") {
                            viewStore.send(.rockButtonTapped)
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        Button("✊") {
                            viewStore.send(.rockButtonTapped)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    if viewStore.playerHand == .paper {
                        Button("✋") {
                            viewStore.send(.paperButtonTapped)
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        Button("✋") {
                            viewStore.send(.paperButtonTapped)
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    if viewStore.playerHand == .scissors {
                        Button("✌️") {
                            viewStore.send(.scissorsButtonTapped)
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        Button("✌️") {
                            viewStore.send(.scissorsButtonTapped)
                        }
                        .buttonStyle(.bordered)
                    }
                }
                if !viewStore.gameOver && viewStore.playerHand != .hidden {
                    Button {
                        viewStore.send(.goButtonTapped)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 120, height: 50)
                            Text("GO!")
                                .foregroundStyle(.white)
                        }
                    }
                } else {
                    Button {
                        viewStore.send(.resetButtonTapped)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 120, height: 50)
                            Text("Reset?")
                                .foregroundStyle(.white)
                        }
                    }
                    .foregroundStyle(.gray)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(store: Store.init(
        initialState: Application.State.init(),
        reducer: { Application() })
    )
}
