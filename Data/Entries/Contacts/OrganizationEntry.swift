import Foundation

struct OrganizationEntry: Decodable {
    let title: Entry<String>?
    let primaryValue: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "gd$orgTitle"
        case primaryValue = "primary"
    }
}
