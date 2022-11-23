import ComposableArchitecture
import Foundation
import SharedModels
import XCTestDynamicOverlay

public class RemoteContactManager {
    private let baseURLString = "http://192.168.15.2:3000"
    private lazy var loginURLString = "\(baseURLString)/login"
    private lazy var contactsURLString = "\(baseURLString)/contacts/%@"
    enum RemoteContactError: Error {
        case configurationError
    }

    public init() {}

    public lazy var login: (String, String) async throws -> Contact = { [weak self] username, password in
        guard let self = self, let url = URL(string: self.loginURLString) else { throw RemoteContactError.configurationError }
        let params = ["username": username, "password": password]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject: params)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let (data, _) = try await URLSession.shared.data(for: request)
        try await Task.sleep(nanoseconds: NSEC_PER_SEC / 2)
        return try JSONDecoder().decode(Contact.self, from: data)
    }

    public lazy var contacts: (UUID) async throws -> [Contact] = { [weak self] userId in
        guard let self = self else { throw RemoteContactError.configurationError }
        let contactsURLString = String(format: self.contactsURLString, userId.uuidString)
        guard let url = URL(string: contactsURLString) else { throw RemoteContactError.configurationError }
        let (data, _) = try await URLSession.shared.data(from: url)
        try await Task.sleep(nanoseconds: NSEC_PER_SEC / 2)
        return try JSONDecoder().decode([Contact].self, from: data)
    }
}

public extension DependencyValues {
    enum RemoteContactManagerKey: DependencyKey {
        public static let liveValue = RemoteContactManager()
        public static var testValue = RemoteContactManager()
    }

    var remoteContactManager: RemoteContactManager {
        get { self[RemoteContactManagerKey.self] }
        set { self[RemoteContactManagerKey.self] = newValue }
    }
}
