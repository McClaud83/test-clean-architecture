import UIKit
import Domain

struct AuthModule {
    let view: UIViewController
    let router: AuthRouter
    
    init(transition: Transition) {
        router = AuthRouter()
        
        let resolver = AppDependencyManager.shared.resolver
        let provider: UseCaseProvider = resolver.resolve(UseCaseProvider.self)
        
        let authUseCase = provider.makeAuthUseCase()
        
        let viewModel = AuthViewModel(container: .init(
            authUseCase: authUseCase,
            router: router
            ))
        
        let view = AuthViewController(container: .init(viewModel: viewModel))
        
        router.viewController = view
        router.openTransition = transition
        
        self.view = view
    }
}
