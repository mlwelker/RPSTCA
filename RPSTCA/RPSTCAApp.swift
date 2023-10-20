
import ComposableArchitecture
import SwiftUI

@main
struct RPSTCAApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store.init(
                initialState: Application.State.init(),
                reducer: { Application(randomHand: liveRandomHand) })
            )
        }
    }
}
