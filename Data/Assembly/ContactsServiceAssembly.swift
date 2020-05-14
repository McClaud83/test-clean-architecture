import Foundation
import Domain
import Swinject

class ContactsServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ContactsService.self) { _ in
            return ContactsServiceImpl()
        }
    }
}
