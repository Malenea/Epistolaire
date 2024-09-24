import Foundation
import Data
import DataProtocols
import Shared

public class ChatsInteractor: ObservableObject {

    private let service: DataServiceProtocol

    public init(service: DataServiceProtocol) {
        self.service = service
    }

    // The domain layer should take care of interpreting the data, that allows to avoid the data layer to have a dependency redundancy with the domain layer
    public func getChats() async -> [Chat] {
        do {
            guard let data = service.getMessagingData() else { return [] }
            let decoder = JSONDecoder()
            let decoded = try decoder.decode([Chat].self, from: data)
            // We're sorting messages here in the domain layer, it's a choice, it could be done also on the data usage level
            return decoded.sorted { $0.lastUpdated > $1.lastUpdated }
        } catch {
            assertionFailure("Model: \(type(of: [Chat].self))" + error.localizedDescription)
            return []
        }
    }

}
