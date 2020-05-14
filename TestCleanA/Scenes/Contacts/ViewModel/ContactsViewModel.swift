import Foundation
import Domain
import RxSwift
import RxCocoa
import Core

struct ContactsViewModel: ViewModel, DIConfigurable {
    private let contactsUseCase: ContactsUseCase
    private let authUseCase: AuthUseCase
    private let router: ContactsRouter
  
    init(container: Container) {
        contactsUseCase = container.contactsUseCase
        authUseCase = container.authUseCase
        router = container.router
    }
    
    func transform(_ input: ContactsViewModel.Input, outputHandler: (ContactsViewModel.Output) -> Void) {
        logout(trigger: input.logoutTrigger)
            .disposed(by: input.disposeBag)
        
        let contacts = fetchContacts(input: input.startTrigger)
        
        let tableData = contacts
            .map(makeCellViewModels)
            .wrappedInEmptySection()
        
        let output = Output(
            tableData: tableData
        )
        
        outputHandler(output)
    }

    private func fetchContacts(input: Driver<Void>) -> Driver<[ContactItem]> {
        return input
            .asObservable()
            .flatMapLatest { _ in
                return self.contactsUseCase
                    .obtainContacts()
            }
            .asDriver(onErrorJustReturn: [])
    }
    
    private func logout(trigger: Driver<Void>) -> Disposable {
        return trigger
            .flatMap { _ in
                return self.authUseCase.signOut()
                    .asDriver(onErrorJustReturn: ())
            }
            .drive(onNext: { _ in
                self.router.showLoading()
            })
    }
        
}

extension ContactsViewModel {
    private func makeCellViewModels(from contacts: [ContactItem]) -> [ContactCellViewModel] {
        return contacts
            .map({
                let presentable = $0 as ContactCellPresentable
                return ContactCellViewModel(contact: presentable)
            })
    }
}

extension ContactsViewModel {
    struct Container {
        let contactsUseCase: ContactsUseCase
        let authUseCase: AuthUseCase
        let router: ContactsRouter
    }
    
    struct Input {
        let startTrigger: Driver<Void>
        let logoutTrigger: Driver<Void>
        let disposeBag: DisposeBag
    }
    
    struct Output {
        let tableData: Driver<[EmptySection<ContactCellViewModel>]>
    }

}
