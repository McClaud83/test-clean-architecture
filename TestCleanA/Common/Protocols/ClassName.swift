import Foundation

protocol ClassName {
    static var className: String { get }
}

extension ClassName {
    
    static var className: String {
        return String(describing: self)
    }
}
