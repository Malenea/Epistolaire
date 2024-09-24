import Foundation

public extension Chat {

    static var fixture: Self {
        .init(
            id: "ChatTestId",
            name: "Hello World",
            lastUpdated: "2024-09-24T06:00:00".toDate,
            messages: [
                .fixture1,
                .fixture2,
                .fixture3
            ]
        )
    }

}
