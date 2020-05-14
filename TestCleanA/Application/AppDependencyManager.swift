import Swinject
import Domain
import Data

class AppDependencyManager {
    
    static let shared = AppDependencyManager()
    
    private let container: Container
    
    var resolver: Resolver {
        return container
    }
    
    private init() {
        let container = Container()
        
        container.register(ServiceProvider.self, factory: { _ in
            return ServiceProvider(container: container)
        })
        
        container.register(UseCaseProvider.self, factory: {
            let serviceResolver: Resolver = $0.resolve(ServiceProvider.self)
                .asResolver()
            
            return UseCaseProvider(container: container, serviceResolver: serviceResolver)
        })
        
        self.container = container
    }
}
