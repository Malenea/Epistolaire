import UIKit

public extension DataService {

//    enum Source {
//        case api
//        case file
//    }

    // If there's an online mode, the domain layer could be responsible to monitor either the offline option if it exists or the network status to use either the API or the locally stored data
    func getMessagingData(/*source: DataService.Source*/) -> Data? {
//        switch source {
//        case .api:
//            getDataFromAPI()
//        case .file:
            getDataFromFile(filename: "ChatList")
//        }
    }

}
