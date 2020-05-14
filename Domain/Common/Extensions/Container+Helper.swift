import Foundation

import Swinject

public extension Resolver {
    
    func resolve<Service>(_ serviceType: Service.Type, by name: String? = nil) -> Service {
        guard let service = resolve(serviceType, name: name) else {
            fatalError("Cannot resolve \(serviceType) ")
        }
        return service
    }
}
