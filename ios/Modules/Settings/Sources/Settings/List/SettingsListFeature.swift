import ComposableArchitecture
import Foundation
import SharedModels

// public struct SettingsFeature: ReducerProtocol {
//    public struct State: Equatable {
//        public var user: Contact?
//
//        public init(user: Contact? = nil) {
//            self.user = user
//        }
//    }
//
//    public enum Action: Equatable {
//        case updateFirstName(name: String)
//        case updateLastName(name: String)
//        case updatePhone(phone: String)
//        case updateEmail(email: String)
//        case updateAddress(address: String)
//        case updatePhoto(photo: URL)
//        case updateStatusMessage(statusMessage: String)
//        case updateJobTitle(jobTitle: String)
//    }
//
//    public init() {}
//
//    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
//        switch action {
//        case let .updateFirstName(name): return updateFirstName(&state, name: name)
//        case let .updateLastName(name): return updateLastName(&state, name: name)
//        case let .updatePhone(phone): return updatePhone(&state, phone: phone)
//        case let .updateEmail(email): return updateEmail(&state, email: email)
//        case let .updateAddress(address): return updateAddress(&state, address: address)
//        case let .updatePhoto(photo): return updatePhoto(&state, photo: photo)
//        case let .updateStatusMessage(statusMessage): return updateStatusMessage(&state, statusMessage: statusMessage)
//        case let .updateJobTitle(jobTitle): return updateJobTitle(&state, jobTitle: jobTitle)
//        }
//    }
//
//    func updateFirstName(_ state: inout State, name: String) -> Effect<Action, Never> {
//        state.user?.firstName = name
//        return .none
//    }
//
//    func updateLastName(_ state: inout State, name: String) -> Effect<Action, Never> {
//        state.user?.lastName = name
//        return .none
//    }
//
//    func updatePhone(_ state: inout State, phone: String) -> Effect<Action, Never> {
//        state.user?.phone = phone
//        return .none
//    }
//
//    func updateEmail(_ state: inout State, email: String) -> Effect<Action, Never> {
//        state.user?.email = email
//        return .none
//    }
//
//    func updateAddress(_ state: inout State, address: String) -> Effect<Action, Never> {
//        state.user?.address = address
//        return .none
//    }
//
//    func updateStatusMessage(_ state: inout State, statusMessage: String) -> Effect<Action, Never> {
//        state.user?.statusMessage = statusMessage
//        return .none
//    }
//
//    func updateJobTitle(_ state: inout State, jobTitle: String) -> Effect<Action, Never> {
//        state.user?.jobTitle = jobTitle
//        return .none
//    }
//
//    func updatePhoto(_ state: inout State, photo: URL) -> Effect<Action, Never> {
//        state.user?.photo = photo
//        return .none
//    }
// }
