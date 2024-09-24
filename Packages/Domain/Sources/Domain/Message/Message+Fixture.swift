import Foundation

public extension Message {

    static var fixture1: Self {
        .init(
            id: "fixture1Id",
            text: "This is a test message number 1",
            lastUpdated: "2024-09-24T06:00:00".toDate
        )
    }

    static var fixture2: Self {
        .init(
            id: "fixture2Id",
            text: "This is a test message number 2",
            lastUpdated: "2024-09-22T03:00:00".toDate
        )
    }

    static var fixture3: Self {
        .init(
            id: "fixture3Id",
            text: "This is a test message number 3",
            lastUpdated: "2024-09-23T09:00:00".toDate
        )
    }

}
