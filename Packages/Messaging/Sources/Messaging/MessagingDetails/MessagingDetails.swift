import SwiftUI
import Domain

public struct MessagingDetails: View {

    public enum Event: Hashable {
        case idle
        case didAppear

        case replied(Message)

        // This is a current workaround for iOS 17 navigation stack back bug, to be replaced
        case tappedBack
    }

    public typealias NavigationEvent = MessagingDetails.Event

    @ObservedObject private var viewModel: ViewModel
    @State private var currentEvent: Event? = .didAppear

    public init(
        chat: Chat,
        onNavigationEvent: @escaping (NavigationEvent) -> Void
    ) {
        self._viewModel = .init(wrappedValue: ViewModel(chat: chat, onNavigationEvents: onNavigationEvent))
    }

    public var body: some View {
        ContentView(
            chat: viewModel.chat,
            onEvent: { currentEvent = $0 }
        )
        .task(id: currentEvent) {
            guard let currentEvent else { return }
            await viewModel.handle(event: currentEvent)
            self.currentEvent = nil
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }

}
