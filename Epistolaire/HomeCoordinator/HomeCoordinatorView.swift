import SwiftUI
import Data
import DataProtocols
import Domain
import Messaging

enum AppPages: Identifiable, Hashable {
    var id: Self { self }

    case messagingHome(DataServiceProtocol)
    case messagingDetails(Chat)

    static func == (lhs: AppPages, rhs: AppPages) -> Bool {
        switch (lhs, rhs) {
        case (.messagingHome, .messagingHome):
                return true
        case (.messagingDetails, .messagingDetails):
            return true
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class HomeCoordinator: ObservableObject {

    @Published var path: NavigationPath = NavigationPath()

    func push(page: AppPages) {
        path.append(page)
    }

    func pop() {
        path.removeLast()
    }

    @ViewBuilder
    func build(page: AppPages) -> some View {
        switch page {
        case .messagingHome(let service):
            MessagingHome(service: service) { event in
                switch event {
                case .tappedOnChat(let chat):
                    self.push(page: .messagingDetails(chat))
                default: break
                }
            }
        case .messagingDetails(let chat):
            MessagingDetails(chat: chat) { event in
                switch event {
                case .tappedBack:
                    self.pop()
                default: break
                }
            }
        }
    }

}

struct HomeCoordinatorView: View {

    private let service = DataService()
    @StateObject private var coordinator = HomeCoordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .messagingHome(service))
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }

}
