import Foundation

struct ContactEntry: Decodable {
    let id: Entry<String>
    let title: Entry<String>?
    let link: [LinkEntry]?
    let organizations: [OrganizationEntry]?
    let name: FullNameEntry
    
    enum CodingKeys: String, CodingKey {
        case organizations = "gd$organization"
        case name = "gd$name"
        case id = "id"
        case title = "title"
        case link = "link"
    }
}
