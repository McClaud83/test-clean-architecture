import Swinject
import Domain

class GoogleSignInAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GoogleSignInService.self) { _ in
            return GoogleSignInServiceImpl()
        }
    }
}
