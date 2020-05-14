import Foundation

enum Constants {
    static let GoogleContactsScope: String = "https://www.googleapis.com/auth/contacts"
    static let ContactsListUrl: String = "https://www.google.com/m8/feeds/gal/65apps.com"
    
    enum UserDefaultsKeys: String {
        case authToken
    }
}
