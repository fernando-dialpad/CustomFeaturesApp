import XCTest
@testable import ContactHeader
import ComposableArchitecture
import SharedModels
import Network

@MainActor
final class ContactHeaderIntegrationTests: XCTestCase {
    func testOnAppear() async throws {
        // Given
        let store = TestStore(initialState: .init(), reducer: ContactHeaderFeature())
        let user = Contact.mock
        let contacts = [Contact.mock]
        let userWithContacts = user.stub { $0.contacts = contacts }
        let photoData = Data()
        store.dependencies.remoteContactManager.login = { username, password in user }
        store.dependencies.remoteContactManager.contacts = { userId in contacts }
        store.dependencies.remoteImageManager.fetchImage = { url in photoData }

        // When
        await store.send(.onAppear) {
            $0.isLoading = true
        }

        // Then
        await store.receive(.local(.updateUser(user: userWithContacts))) {
            $0.user = userWithContacts
            $0.isLoading = false
        }

        await store.receive(.local(.updatePhoto(data: photoData))) {
            $0.photoData = photoData
        }
    }

    func testOnAppearAlternative() async throws {
        // Given
        let store = TestStore(initialState: .init(user: nil, photoData: nil, isLoading: true), reducer: ContactHeaderFeature())
        store.exhaustivity = .off
        let user = Contact.mock
        let contacts = [Contact.mock]
        let userWithContacts = user.stub { $0.contacts = contacts }
        let photoData = Data()
        store.dependencies.remoteContactManager.login = { username, password in user }
        store.dependencies.remoteContactManager.contacts = { userId in contacts }
        store.dependencies.remoteImageManager.fetchImage = { url in photoData }

        // When
        await store.send(.onAppear)
        await store.skipReceivedActions()

        // Then
        XCTAssertEqual(store.state.user, userWithContacts)
        XCTAssertEqual(store.state.photoData, photoData)
        XCTAssertEqual(store.state.isLoading, false)
    }
}
