import XCTest
@testable import ContactHeader
import ComposableArchitecture
import SharedModels
import Network

@MainActor
final class ContactHeaderUnitTests: XCTestCase {
    func testUpdateUser() async throws {
        // Given
        let store = TestStore(initialState: .init(user: nil, isLoading: true), reducer: ContactHeaderFeature())
        store.exhaustivity = .off

        // When
        let user = Contact.mock
        _ = await store.send(.local(.updateUser(user: user)))

        // Then
        XCTAssertEqual(store.state.user, user)
        XCTAssertEqual(store.state.isLoading, false)
    }

    func testUpdatePhoto() async throws {
        // Given
        let store = TestStore(initialState: .init(photoData: nil), reducer: ContactHeaderFeature())
        store.exhaustivity = .off

        // When
        let data = Data()
        _ = await store.send(.local(.updatePhoto(data: data)))

        // Then
        XCTAssertEqual(store.state.photoData, data)
    }

    func testOnAppear() async throws {
        // Given
        let store = TestStore(initialState: .init(isLoading: false), reducer: ContactHeaderFeature())
        store.exhaustivity = .off

        // When
        _ = await store.send(.onAppear)

        // Then
        XCTAssertTrue(store.state.isLoading)
    }
}

