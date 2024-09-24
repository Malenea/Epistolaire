import Foundation
import Shared

public struct Chat: Identifiable, Decodable, Equatable, Hashable {

    public let id: String
    public let name: String
    public let lastUpdated: Date
    public var messages: [Message]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case lastUpdated = "last_updated"
        case messages
    }

    public static func == (lhs: Chat, rhs: Chat) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(lastUpdated)
    }

    public init(id: String, name: String, lastUpdated: Date, messages: [Message]) {
        self.id = id
        self.name = name
        self.lastUpdated = lastUpdated
        self.messages = messages
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.lastUpdated = try container.decode(String.self, forKey: .lastUpdated).toDate
        // We're sorting messages here in the domain layer, it's a choice, it could be done also on the data usage level
        self.messages = try container.decode([Message].self, forKey: .messages).sorted { $0.lastUpdated < $1.lastUpdated }
    }

}
