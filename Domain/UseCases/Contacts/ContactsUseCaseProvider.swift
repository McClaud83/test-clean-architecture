import Foundation

public protocol ConstactUseCaseProvider {
    func makeContactsUseCase() -> ContactsUseCase
}
