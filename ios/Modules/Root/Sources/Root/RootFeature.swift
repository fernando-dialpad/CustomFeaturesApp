import ContactList
import ContactHeader
import ComposableArchitecture
import Settings
import SharedModels

public struct RootFeature: ReducerProtocol {
    public struct State: Equatable {
        public var header = ContactHeaderFeature.State() {
            didSet {
                updateContacts()
                updateSettings()
            }
        }
        public var contactList = ContactListFeature.State()
        public var infoSettings = InfoSettingsFeature.State()
        public var detailsSettings = DetailsSettingsFeature.State()

        public init() {}

        private mutating func updateContacts() {
            header.user?.contacts
                .forEach { contact in
                    guard contactList.contacts[id: contact.id] != nil else {
                        contactList.contacts[id: contact.id] = ContactFeature.State.init(contact: contact)
                        return
                    }
                    contactList.contacts[id: contact.id]?.contact = contact
                }
        }

        private mutating func updateSettings() {
            infoSettings.user = header.user
            detailsSettings.user = header.user
        }
    }

    public enum Action: Equatable {
        case header(ContactHeaderFeature.Action)
        case contactList(ContactListFeature.Action)
        case infoSettings(InfoSettingsFeature.Action)
        case detailsSettings(DetailsSettingsFeature.Action)
    }

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \.header, action: /Action.header) {
            ContactHeaderFeature()
        }
        Scope(state: \.contactList, action: /Action.contactList) {
            ContactListFeature()
        }
        Scope(state: \.infoSettings, action: /Action.infoSettings) {
            InfoSettingsFeature()
        }
        Scope(state: \.detailsSettings, action: /Action.detailsSettings) {
            DetailsSettingsFeature()
        }
    }
}
