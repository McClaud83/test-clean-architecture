import Foundation

public enum Environment {
}

extension Environment {
    static let googleApiKey: String = {
        return valueFromPlist(for: Keys.Plist.googleApiKey)
    }()
}

extension Environment {
    
    enum Keys {
        enum Plist {
            static let googleApiKey = "GOOGLE_KEY"
        }
    }
    
    // MARK: - Plist
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    private static func valueFromPlist<T>(for key: String) -> T {
        guard let value = Environment.infoDictionary[key] as? T else {
            fatalError("Value for key: \(key) not found in plist for this environment")
        }
        return value
    }
}
