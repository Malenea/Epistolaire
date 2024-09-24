import XCTest
import SnapshotTesting
import Domain
import DataMocks
@testable import Messaging

// MARK: - Unit test
final class MessagingTests: XCTestCase {

    // I don't find this test very meaningful as it is, it was just to demonstrate a unit test to ensure our interactor works, but it would be nice to test more business logic in it
    func testGetChats() async {
        let interactor = ChatsInteractor(service: DataServiceMock())
        let chats = await interactor.getChats()
        XCTAssertEqual(chats, [.fixture])
    }

}

// MARK: - Snapshot test
final class SnapshotMessagingTests: XCTestCase {

    @MainActor
    func testSnapshotMessagingHome() async {
        let interactor = ChatsInteractor(service: DataServiceMock())
        let chats = await interactor.getChats()
        let view = MessagingHome.ContentView(chats: chats) { _ in }//(service: DataServiceMock()) { _ in }
        assertSnapshot(of: view, as: .image(precision: 0.98, perceptualPrecision: 0.98, layout: .device(config: .iPhone8Plus)))
    }

    @MainActor
    func testSnapshotMessagingDetails() async {
        let interactor = ChatsInteractor(service: DataServiceMock())
        let chats = await interactor.getChats()
        guard let chat = chats.first else {
            XCTFail("Failed to get first chat")
            return
        }
        let view = MessagingDetails(chat: chat) { _ in }
        assertSnapshot(of: view, as: .image(precision: 0.98, perceptualPrecision: 0.98, layout: .device(config: .iPhone8Plus)))
    }

}
