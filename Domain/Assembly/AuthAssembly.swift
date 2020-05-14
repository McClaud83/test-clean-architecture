import Swinject

class AuthAssembly: Assembly {
    
    private let serviceResolver: Resolver
    
    init(serviceResolver: Resolver) {
        self.serviceResolver = serviceResolver
    }
    
    func assemble(container: Container) {
        container.register(AuthUseCase.self, factory: { resolver in
            return AuthUseCaseImpl(
                storageService: resolver.resolve(StorageService.self),
                signInService: resolver.resolve(GoogleSignInService.self))
        })
    }
}
