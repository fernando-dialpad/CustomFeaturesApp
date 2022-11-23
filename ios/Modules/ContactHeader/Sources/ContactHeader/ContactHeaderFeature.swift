import ComposableArchitecture
import Foundation
import Network
import SharedModels

public struct ContactHeaderFeature: ReducerProtocol {
    public struct State: Equatable {
        public var photoData: Data?
        public var user: Contact?
        public var isLoading: Bool

        public init(user: Contact? = nil, photoData: Data? = nil, isLoading: Bool = false) {
            self.user = user
            self.photoData = photoData
            self.isLoading = isLoading
        }
    }

    public enum Action: Equatable {
        public enum LocalAction: Equatable {
            case updateUser(user: Contact)
            case updatePhoto(data: Data)
        }
        case onAppear
        case local(LocalAction)
    }

    public init() {}

    @Dependency(\.remoteContactManager) private var remoteContactManager
    @Dependency(\.remoteImageManager) private var remoteImageManager

    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case .onAppear: return onAppear(&state)
        case let .local(.updateUser(user)): return updateUser(&state, user: user)
        case let .local(.updatePhoto(data)): return updatePhoto(&state, data: data)
        }
    }

    func updatePhoto(_ state: inout State, data: Data) -> Effect<Action, Never> {
        state.photoData = data
        return .none
    }

    func onAppear(_ state: inout State) -> Effect<Action, Never> {
        state.isLoading = true
        return .run { send in
            var user = try await remoteContactManager.login("myusername", "mypassword")
            let contacts = try await remoteContactManager.contacts(user.id)
            user.contacts = contacts
            await send(.local(.updateUser(user: user)))
            let photoData = try await remoteImageManager.fetchImage(user.photo)
            await send(.local(.updatePhoto(data: photoData)))
        }
    }

    func updateUser(_ state: inout State, user: Contact) -> Effect<Action, Never> {
        state.user = user
        state.isLoading = false
        return .none
    }
}

// public struct ContactHeaderFeature: ReducerProtocol {
//    public struct State: Equatable {
//        public var photoData: Data?
//        public var user: Contact?
//
//        public init(user: Contact? = nil, photoData: Data? = nil) {
//            self.user = user
//            self.photoData = photoData
//        }
//    }
//
//    public enum Action: Equatable {
//        case onAppear
//        case user(Contact)
//        case contacts([Contact])
//        case photo(Data)
//    }
//
//    public init() {}
//
//    @Dependency(\.remoteContactManager) private var remoteContactManager
//    @Dependency(\.remoteImageManager) private var remoteImageManager
//
//    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
//        switch action {
//        case let .photo(data):
//            state.photoData = data
//            return .none
//        case let .user(user):
//            state.user = user
//            return contacts(user: user)
//        case .onAppear:
//            return user()
//        case let .contacts(contacts):
//            state.user?.contacts = contacts
//            return photo(user: state.user)
//        }
//    }
//
//    func photo(user: Contact?) -> Effect<Action, Never> {
//        .future { callback in
//            Task {
//                let data = try await remoteImageManager.fetchImage(user?.photo)
//                callback(.success(.photo(data)))
//            }
//        }
//    }
//
//    func user() -> Effect<Action, Never> {
//        .future { callback in
//            Task {
//                let user = try await remoteContactManager.login("myusername", "mypassword")
//                callback(.success(.user(user)))
//            }
//        }
//    }
//
//    func contacts(user: Contact) -> Effect<Action, Never> {
//        .future { callback in
//            Task {
//                let contacts = try await remoteContactManager.contacts(user.id)
//                callback(.success(.contacts(contacts)))
//            }
//        }
//    }
// }
