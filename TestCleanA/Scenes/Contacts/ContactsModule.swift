import Foundation
import Domain
import UIKit.UIViewController

struct ContactsModule {
    let view: UIViewController
    let router: ContactsRouter
    
    init(transition: Transition) {
        router = ContactsRouter()
        router.openTransition = transition
        
        let resolver = AppDependencyManager.shared.resolver
        let provider: UseCaseProvider = resolver.resolve(UseCaseProvider.self)
        
        let viewModel = ContactsViewModel(container: .init(
            contactsUseCase: provider.makeContactsUseCase(),
            authUseCase: provider.makeAuthUseCase(),
            router: router
        ))
        
        let view = ContactsViewController(container: .init(viewModel: viewModel))
        
        router.viewController = view
        
        self.view = view
    }
}
