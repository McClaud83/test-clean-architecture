import Foundation

public struct GoogleUserInfo {
    public let id: String
    public let authToken: String
    public let name: String
    
    public init(
        id: String,
        authToken: String,
        name: String
    ) {
        self.id = id
        self.authToken = authToken
        self.name = name
    }
}
