import Foundation

struct Entry<T: Decodable>: Decodable {
    let value: T
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try! container.decode(T.self, forKey: .value)
    }
    
    enum CodingKeys: String, CodingKey {
        case value = "$t"
    }
}
