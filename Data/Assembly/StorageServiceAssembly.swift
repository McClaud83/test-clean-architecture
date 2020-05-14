import Swinject
import Domain

class StorageServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(StorageService.self) { _ in
            return StorageServiceImpl()
        }
    }
}
