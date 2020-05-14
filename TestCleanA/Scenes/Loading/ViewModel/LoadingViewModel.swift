import Foundation
import Domain
import RxSwift
import RxCocoa
import RxSwiftExt
import Core

struct LoadingViewModel: ViewModel, DIConfigurable {
    private let authUseCase: Domain.AuthUseCase
    private let router: LoadingRouter

    init(container: LoadingViewModel.Container) {
        authUseCase = container.authUseCase
        router = container.router
    }

    func transform(
        _ input: LoadingViewModel.Input,
        outputHandler: (LoadingViewModel.Output) -> Void)
    {
        let auth = isUserAuthorised(input: input.startTrigger)
        
        let userNotAuthorised = auth
            .filter({ $0 == false })
            .mapTo(())
        
        let userAuthorised = auth
            .filter({ $0 == true })
            .mapTo(())
            .withLatestFrom(input.controller)
         
        let tokenUpdate = checkToken(input: userAuthorised)
            .flatMap({ _ -> Driver<Bool> in
                print("Updated token")
                return self.isUserAuthorised(input: input.startTrigger)
            })
        
        let tokenUpdateSuccess = tokenUpdate
            .filter({ $0 == true })
            .mapTo(())
        
        let tokenUpdateFailed = tokenUpdate
            .filter({ $0 == false })
            .mapTo(())

        showSignIn(input: Driver.merge(
                userNotAuthorised,
                tokenUpdateFailed
            ))
            .disposed(by: input.disposeBag)


        showContacts(input: tokenUpdateSuccess)
            .disposed(by: input.disposeBag)
        
        let output = Output()

        outputHandler(output)
    }
    
    private func isUserAuthorised(input: Driver<Void>) -> Driver<Bool> {
        return input
            .flatMap({
                return self.authUseCase.isUserAuthorised()
                    .asDriver(onErrorJustReturn: false)
            })
    }
    
    private func showSignIn(input: Driver<Void>) -> Disposable {
        return input
            .drive(onNext: { _ in
                self.router.showAuth()
            })
    }
    
    private func showContacts(input: Driver<Void>) -> Disposable {
        return input
            .drive(onNext: { _ in
                self.router.showContacts()
            })
    }
    
    private func checkToken(input: Driver<UIViewController>) -> Driver<Void> {
        return input
            .flatMapLatest { controller in
                return self.authUseCase.refreshToken(on: controller)
                    .asDriver(onErrorJustReturn: ())
            }
    }
}

extension LoadingViewModel {
    struct Input {
        let startTrigger: Driver<Void>
        let controller: Driver<UIViewController>
        let disposeBag: DisposeBag
    }

    struct Output {
    }

    struct Container {
        let authUseCase: Domain.AuthUseCase
        let router: LoadingRouter
    }
}

