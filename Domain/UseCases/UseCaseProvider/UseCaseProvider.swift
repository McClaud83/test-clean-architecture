import Swinject

public class UseCaseProvider {
    private let container: Container
    private let assembler: Assembler
    
    public init(container: Container = Container(), serviceResolver: Resolver) {
        self.container = container
        
        assembler = Assembler(
            [
                AuthAssembly(serviceResolver: serviceResolver),
                ContactsAssembly(serviceResolver: serviceResolver)
            ],
            container: container
        )
    }
}

extension UseCaseProvider: AuthUseCaseProvider {
    public func makeAuthUseCase() -> AuthUseCase {
        return container.resolve(AuthUseCase.self)
    }
}

extension UseCaseProvider: ConstactUseCaseProvider {
    public func makeContactsUseCase() -> ContactsUseCase {
        return container.resolve(ContactsUseCase.self)
    }
}
