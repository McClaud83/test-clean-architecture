import Foundation
import Core
import Domain 
import RxSwift
import RxCocoa

struct AuthViewModel: ViewModel, DIConfigurable {
    private let router: AuthRouter
    private let authUseCase: AuthUseCase
    
    init(container: Container) {
        authUseCase = container.authUseCase
        router = container.router
    }
    
    func transform(_ input: AuthViewModel.Input, outputHandler: (AuthViewModel.Output) -> Void) {
        signIn(trigger: input.signInTrigger)
            .disposed(by: input.disposeBag)
    }
    
    private func signIn(trigger: Driver<UIViewController>) -> Disposable {
        return trigger
            .flatMapLatest({ controller in
                return self.authUseCase.signInWithGoogle(on: controller)
                    .asDriver(onErrorJustReturn: ())
            })
            .drive(onNext: { controller in
                self.router.showContacts()
            })
    }
}

extension AuthViewModel {
    struct Input {
        let disposeBag: DisposeBag
        let signInTrigger: Driver<UIViewController>
    }
    
    struct Output {
    }
    
    struct Container {
        let authUseCase: AuthUseCase
        let router: AuthRouter
    }
}
