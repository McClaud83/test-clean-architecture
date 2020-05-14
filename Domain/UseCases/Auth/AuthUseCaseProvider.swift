import Foundation

public protocol AuthUseCaseProvider {
    func makeAuthUseCase() -> AuthUseCase
}
