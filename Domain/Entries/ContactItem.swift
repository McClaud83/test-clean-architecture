import Foundation

public struct ContactItem {
    public let id: String
    public let name: String
    
    public init(
        id: String,
        name: String
    ) {
        self.id = id
        self.name = name
    }
}
