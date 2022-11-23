import ComposableArchitecture
import Foundation
import SharedModels

public class RemoteImageManager {
    enum RemoteImageError: Error {
        case invalidURL
    }
    private var cache = NSCache<NSString, NSData>()

    public init() {}

    public lazy var fetchImage: (URL?) async throws -> Data = { [weak self] url in
        guard let url = url else { throw RemoteImageError.invalidURL }
        if let cached = self?.cache.object(forKey: url.absoluteString as NSString) {
            return Data(referencing: cached)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        try await Task.sleep(nanoseconds: NSEC_PER_SEC / 2)
        self?.cache.setObject(data as NSData, forKey: url.absoluteString as NSString)
        return data
    }
}

public extension DependencyValues {
    enum RemoteImageManagerKey: DependencyKey {
        public static let liveValue = RemoteImageManager()
        public static var testValue = RemoteImageManager()
    }

    var remoteImageManager: RemoteImageManager {
        get { self[RemoteImageManagerKey.self] }
        set { self[RemoteImageManagerKey.self] = newValue }
    }
}
