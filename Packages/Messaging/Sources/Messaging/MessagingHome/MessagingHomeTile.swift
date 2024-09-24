import SwiftUI
import Shared

struct MessagingHomeTile: View {

    let name: String
    let date: Date
    let lastMessage: String?

    init(
        name: String,
        date: Date,
        lastMessage: String?
    ) {
        self.name = name
        self.date = date
        self.lastMessage = lastMessage
    }

    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack {
                Text(name)
                    .lineLimit(1)
                Spacer()
                Text(date.toFormattedString)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            if let lastMessage = lastMessage {
                Text(lastMessage)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                    .lineLimit(2)
            }
        }
    }

}
