import Foundation

protocol ContactsRoute {
    func showContacts()
}

extension ContactsRoute where Self: RouterProtocol {
    func showContacts() {
        let transition = WindowNavigationTransition()
        let module = ContactsModule(transition: transition)
        self.open(module.view, transition: transition)
    }
}
