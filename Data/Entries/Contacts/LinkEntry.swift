import Foundation

struct LinkEntry: Decodable {
    let rel: String
    let href: String
    let type: String
}
