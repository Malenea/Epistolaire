import Foundation
import DataProtocols
import Domain

public extension MessagingHome {

    @MainActor
    class ViewModel: ObservableObject {

        @Published var chats: [Chat] = []
        private let interactor: ChatsInteractor
        private let onNavigationEvents: (NavigationEvent) -> Void

        init(
            interactor: ChatsInteractor,
            onNavigationEvents: @escaping (NavigationEvent) -> Void
        ) {
            self.interactor = interactor
            self.onNavigationEvents = onNavigationEvents
        }

        func handle(event: Event) async {
            switch event {
            case .didAppear:
                await initialLoad()
            case .tappedOnChat(let chat):
                onNavigationEvents(.tappedOnChat(chat))
            default: break
            }
        }

        private func initialLoad() async {
            chats = await fetchChats()
        }

        private func fetchChats() async -> [Chat] {
            await interactor.getChats()
        }

    }

}
