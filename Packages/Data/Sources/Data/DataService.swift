import Foundation
import DataProtocols

extension Bundle {

    static var data: Bundle = .module

}

public class DataService: DataServiceProtocol {

    public init() {
    }

    func getDataFromAPI() -> Data? {
        nil
    }

    // For now we're using a json file, but if this is meant to be offline mode, then saving messages should be done in a more secure way. Depending on the level of security required, we could use core data or higher encryption local storage solutions
    func getDataFromFile(filename: String) -> Data? {
        guard let path = Bundle.data.path(forResource: filename, ofType: "json") else {
            fatalError("Couldn't get path for \(filename) from bundle")
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return data
        } catch {
            fatalError("Couldn't load \(filename) from bundle:\n\(error)")
        }
    }

}
