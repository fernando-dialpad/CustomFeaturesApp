import ComposableArchitecture
import Foundation
import SharedModels

public struct DetailsSettingsFeature: ReducerProtocol {
    public struct State: Equatable {
        public var user: Contact?

        public init(user: Contact? = nil) {
            self.user = user
        }
    }

    public enum Action: Equatable {
        case updatePhoto(photo: URL)
        case updateStatusMessage(statusMessage: String)
        case updateJobTitle(jobTitle: String)
    }

    public init() {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
        switch action {
        case let .updatePhoto(photo): return updatePhoto(&state, photo: photo)
        case let .updateStatusMessage(statusMessage): return updateStatusMessage(&state, statusMessage: statusMessage)
        case let .updateJobTitle(jobTitle): return updateJobTitle(&state, jobTitle: jobTitle)
        }
    }

    func updateStatusMessage(_ state: inout State, statusMessage: String) -> Effect<Action, Never> {
        state.user?.statusMessage = statusMessage
        return .none
    }

    func updateJobTitle(_ state: inout State, jobTitle: String) -> Effect<Action, Never> {
        state.user?.jobTitle = jobTitle
        return .none
    }

    func updatePhoto(_ state: inout State, photo: URL) -> Effect<Action, Never> {
        state.user?.photo = photo
        return .none
    }
}
