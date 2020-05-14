import UIKit
import Domain

struct LoadingModule {
    let view: UIViewController
    let router: LoadingRouter

    init() {
        router = LoadingRouter()
        let resolver = AppDependencyManager.shared.resolver
        let provider: UseCaseProvider = resolver.resolve(UseCaseProvider.self)

        let authUseCase = provider.makeAuthUseCase()

        let viewModel = LoadingViewModel(container: .init(
            authUseCase: authUseCase,
            router: router
        ))

        let view = LoadingViewController(container: .init(viewModel: viewModel))

        router.viewController = view

        self.view = view
    }
}
