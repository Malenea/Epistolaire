import SwiftUI
import DataProtocols
import Domain

public struct MessagingHome: View {

    public enum Event: Hashable {
        case idle
        case didAppear

        // Depending on API it would be a good practice to pass just the id and not the entire object, so that we can either fetch it or retrieve it from cache instead
        case tappedOnChat(Chat)
    }

    public typealias NavigationEvent = MessagingHome.Event

    @ObservedObject private var viewModel: ViewModel
    @State private var currentEvent: Event? = .didAppear

    public init(
        service: DataServiceProtocol,
        onNavigationEvent: @escaping (NavigationEvent) -> Void
    ) {
        self._viewModel = .init(wrappedValue: ViewModel(interactor: .init(service: service), onNavigationEvents: onNavigationEvent))
    }

    public var body: some View {
        ContentView(
            chats: viewModel.chats,
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
