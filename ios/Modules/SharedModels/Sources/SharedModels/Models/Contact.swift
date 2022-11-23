import Foundation

public struct Contact: Hashable, Decodable, Identifiable {
    public var id: UUID
    public var firstName: String
    public var lastName: String
    public var phone: String
    public var email: String
    public var address: String
    public var photo: URL?
    public var statusMessage: String
    public var jobTitle: String
    public var contacts: [Contact]

    public init(
        id: UUID,
        firstName: String,
        lastName: String,
        phone: String,
        email: String,
        address: String,
        photo: URL?,
        statusMessage: String,
        jobTitle: String,
        contacts: [Contact]
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.address = address
        self.photo = photo
        self.statusMessage = statusMessage
        self.jobTitle = jobTitle
        self.contacts = contacts
    }
}
