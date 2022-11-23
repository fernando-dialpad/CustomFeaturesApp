import ComposableArchitecture
import Foundation
import SharedModels

public struct ContactListFeature: ReducerProtocol {
    public struct State: Equatable {
        public var isLoading: Bool
        public var contacts: IdentifiedArrayOf<ContactFeature.State> {
            didSet {
                isLoading = contacts.isEmpty
            }
        }

        public init(contacts: IdentifiedArrayOf<ContactFeature.State> = [], isLoading: Bool = true) {
            self.contacts = contacts
            self.isLoading = isLoading
        }
    }

    public enum Action: Equatable {
        case contact(id: ContactFeature.State.ID, action: ContactFeature.Action)
    }

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        EmptyReducer()
            .forEach(\.contacts, action: /Action.contact) {
                ContactFeature()
            }
    }
}
