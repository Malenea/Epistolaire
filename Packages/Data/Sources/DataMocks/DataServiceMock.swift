import Foundation
import DataProtocols

extension Bundle {

    static var data: Bundle = .module

}

public struct DataServiceMock: DataServiceProtocol {

    public init() {
    }

    public func getMessagingData() -> Data? {
        guard let path = Bundle.data.path(forResource: "ChatListMock", ofType: "json") else {
            fatalError("Couldn't get path for ChatListMock from bundle")
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            fatalError("Couldn't load ChatListMock from bundle:\n\(error)")
        }
    }
    
}
