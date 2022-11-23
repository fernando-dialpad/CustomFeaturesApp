import Foundation
import SharedModels

extension Contact {
    static var mock: Contact {
        Contact(
            id: UUID(),
            firstName: "Fernando",
            lastName: "Del Rio",
            phone: "(123) 456-7890",
            email: "",
            address: "",
            photo: URL(string: "https://google.com"),
            statusMessage: "",
            jobTitle: "",
            contacts: []
        )
    }

    func stub(stubbing: (inout Self) -> Void) -> Self {
        var `self` = self
        stubbing(&`self`)
        return `self`
    }
}
