import ComposableArchitecture
import Foundation
import Network
import SharedModels

public struct ContactFeature: ReducerProtocol {
    public struct State: Hashable, Identifiable {
        public var id: UUID
        public var contact: Contact
        public var photoData: Data?

        public init(contact: Contact, photoData: Data? = nil) {
            self.contact = contact
            self.photoData = photoData
            id = contact.id
        }
    }

    public enum Action: Equatable {
        public enum LocalAction: Equatable {
            case updatePhoto(data: Data)
        }
        case onAppear
        case local(LocalAction)
    }

    public init() {}

    @Dependency(\.remoteImageManager) var remoteImageManager

    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .onAppear: return onAppear(&state)
        case let .local(.updatePhoto(data)): return updatePhoto(&state, data: data)
        }
    }

    func onAppear(_ state: inout State) -> Effect<Action, Never> {
        .run { [url = state.contact.photo] send in
            let photoData = try await remoteImageManager.fetchImage(url)
            await send(.local(.updatePhoto(data: photoData)))
        }
    }

    func updatePhoto(_ state: inout State, data: Data) -> Effect<Action, Never> {
        state.photoData = data
        return .none
    }
}
