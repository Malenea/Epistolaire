import Foundation
import Shared

public struct Message: Decodable, Identifiable, Equatable, Hashable {

    public let id: String
    public let text: String
    public let lastUpdated: Date

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case lastUpdated = "last_updated"
    }

    public init(id: String, text: String, lastUpdated: Date) {
        self.id = id
        self.text = text
        self.lastUpdated = lastUpdated
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.text = try container.decode(String.self, forKey: .text)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated).toDate
    }

}
