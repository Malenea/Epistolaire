import Foundation

// Protocol for dependency injection. Because the stored data is changing from inputs and updates, for testing purposes we need to mock the data service to get mock data
public protocol DataServiceProtocol {

    func getMessagingData() -> Data?

}
