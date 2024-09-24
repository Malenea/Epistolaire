import SwiftUI
import Domain

public extension MessagingDetails {

    struct ContentView: View {

        let chat: Chat

        @State var reply: String = ""
        let onEvent: (Event) -> Void

        init(
            chat: Chat,
            onEvent: @escaping (Event) -> Void
        ) {
            self.chat = chat
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
                ZStack {
                    Text(chat.name)
                        .font(.title3)
                        .accessibilityIdentifier(chat.id)
                    HStack {
                        Button {
                            onEvent(.tappedBack)
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                        .padding(.vertical, 8.0)
                        Spacer()
                    }
                }

                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16.0) {
                        ForEach(chat.messages) { message in
                            MessagingDetailsTile(text: message.text, date: message.lastUpdated)
                                .padding(.trailing, 64.0)
                        }
                    }
                    .padding(.bottom, 32.0)
                }
                .defaultScrollAnchor(.bottom)
                HStack(spacing: 8.0) {
                    TextField("Reply", text: $reply)
                        .padding(8.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8.0)
                                .stroke(Color.gray, lineWidth: 1.0)
                        )
                    Button {
                        // If the reply is empty, we should not save anything
                        guard !reply.isEmpty else { return }
                        // ATM we have no way of differentiating a message from the user or the recipient, thus them being displayed in the same way. We could add some userId to be able to sort them accordingly imo
                        let message = Message(id: UUID().uuidString, text: reply, lastUpdated: Date())
                        onEvent(.replied(message))
                        reply = ""
                    } label: {
                        Text("Send")
                    }
                    .buttonStyle(.borderedProminent)

                }
                .padding(16.0)
            }
            .padding(.horizontal, 16.0)
                
        }

    }

}
