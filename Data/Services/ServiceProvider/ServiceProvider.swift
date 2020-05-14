import Domain
import Swinject

public class ServiceProvider {
    private let container: Container
    private let assembler: Assembler
    
    public init(container: Container = Container()) {
        self.container = container
        
        assembler = Assembler(
            [
                StorageServiceAssembly(),
                GoogleSignInAssembly(),
                ContactsServiceAssembly()
            ],
            container: container
        )
    }
    
    public func asResolver() -> Resolver {
        return assembler.resolver
    }
}
