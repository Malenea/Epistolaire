import SwiftUI
import Domain
import Shared

public extension MessagingHome {

    struct ContentView: View {

        let chats: [Chat]

        let onEvent: (Event) -> Void

        init(
            chats: [Chat],
            onEvent: @escaping (Event) -> Void
        ) {
            self.chats = chats
            self.onEvent = onEvent
        }

        public var body: some View {
            contentView
                .onAppear {
                    onEvent(.didAppear)
                }
        }

        private var contentView: some View {
            VStack {
                Text("Chats")
                    .font(.title3)
                    .padding(.vertical, 8.0)
                    .padding(.horizontal, 16.0)
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16.0) {
                        ForEach(chats) { chat in
                            VStack {
                                MessagingHomeTile(
                                    name: chat.name,
                                    date: chat.lastUpdated,
                                    lastMessage: chat.messages.last?.text
                                )
                                .accessibilityIdentifier(chat.id)
                                .padding(.horizontal, 16.0)
                                // I would replace that with a styled button if given time
                                .onTapGesture {
                                    onEvent(.tappedOnChat(chat))
                                }

                                Divider()
                                    .padding(.leading, 16.0)
                            }
                        }
                    }
                }
            }
        }

    }

}
