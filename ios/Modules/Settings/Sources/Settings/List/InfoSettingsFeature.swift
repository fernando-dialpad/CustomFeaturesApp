import ComposableArchitecture
import Foundation
import SharedModels

public struct InfoSettingsFeature: ReducerProtocol {
    public struct State: Equatable {
        public var user: Contact?

        public init(user: Contact? = nil) {
            self.user = user
        }
    }

    public enum Action: Equatable {
        case updateFirstName(name: String)
        case updateLastName(name: String)
        case updatePhone(phone: String)
        case updateEmail(email: String)
        case updateAddress(address: String)
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case let .updateFirstName(name): return updateFirstName(&state, name: name)
        case let .updateLastName(name): return updateLastName(&state, name: name)
        case let .updatePhone(phone): return updatePhone(&state, phone: phone)
        case let .updateEmail(email): return updateEmail(&state, email: email)
        case let .updateAddress(address): return updateAddress(&state, address: address)
        }
    }

    func updateFirstName(_ state: inout State, name: String) -> Effect<Action, Never> {
        state.user?.firstName = name
        return .none
    }

    func updateLastName(_ state: inout State, name: String) -> Effect<Action, Never> {
        state.user?.lastName = name
        return .none
    }

    func updatePhone(_ state: inout State, phone: String) -> Effect<Action, Never> {
        state.user?.phone = phone
        return .none
    }

    func updateEmail(_ state: inout State, email: String) -> Effect<Action, Never> {
        state.user?.email = email
        return .none
    }

    func updateAddress(_ state: inout State, address: String) -> Effect<Action, Never> {
        state.user?.address = address
        return .none
    }
}
