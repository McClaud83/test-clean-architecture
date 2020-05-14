import Foundation

struct FullNameEntry: Decodable {
    let fullName: Entry<String>
    
    enum CodingKeys: String, CodingKey {
        case fullName = "gd$fullName"
    }
}
