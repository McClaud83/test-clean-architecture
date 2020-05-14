import Foundation

struct ContactsResponse: Decodable {
    let version: String
    let encoding: String
    let feed: FeedEntry
}
