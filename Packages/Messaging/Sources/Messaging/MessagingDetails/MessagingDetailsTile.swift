import SwiftUI

struct MessagingDetailsTile: View {

    let text: String
    let date: Date

    init(text: String, date: Date) {
        self.text = text
        self.date = date
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(text)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.white)
                .padding(.top, 16.0)
                .padding(.horizontal, 16.0)
            HStack {
                Spacer()
                Text(date.toFormattedString)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 8.0)
            .padding(.bottom, 16.0)
            .padding(.horizontal, 16.0)
        }
        .background(Color(.darkGray))
        .cornerRadius(8.0)
    }

}
