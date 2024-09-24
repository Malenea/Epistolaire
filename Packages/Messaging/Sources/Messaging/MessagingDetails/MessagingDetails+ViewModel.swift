import SwiftUI
import Domain

public extension MessagingDetails {

    @MainActor
    class ViewModel: ObservableObject {

        @Published var chat: Chat
        private let onNavigationEvents: (NavigationEvent) -> Void

        init(
            chat: Chat,
            onNavigationEvents: @escaping (NavigationEvent) -> Void
        ) {
            self.chat = chat
            self.onNavigationEvents = onNavigationEvents
        }

        func handle(event: Event) async {
            switch event {
            case .didAppear:
                await initialLoad()
            case .replied(let message):
                // This should be a call API to update the messages on appear, if offline, then we could store them in CoreData and sync messages offline until we can sync them online
                chat.messages.append(message)
            case .tappedBack:
                onNavigationEvents(.tappedBack)
            default: break
            }
        }

        // We would fetch any new updates in the chat using timestamps from the API or the local storage
        private func initialLoad() async {
            await fetchChatUpdates()
        }

        private func fetchChatUpdates() async {
        }

    }

}
