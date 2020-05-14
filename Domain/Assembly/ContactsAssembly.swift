import Swinject

class ContactsAssembly: Assembly {
    
    private let serviceResolver: Resolver
    
    init(serviceResolver: Resolver) {
        self.serviceResolver = serviceResolver
    }
    
    func assemble(container: Container) {
        container.register(ContactsUseCase.self) { resolver in
            return ContactsUseCaseImpl(
                contactsService: resolver.resolve(ContactsService.self)
            )
        }
    }
}

