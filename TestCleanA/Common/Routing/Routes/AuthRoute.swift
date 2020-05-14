import Foundation

protocol AuthRoute {
    func showAuth()
}

extension AuthRoute where Self: RouterProtocol {
    func showAuth() {
        let transition = WindowNavigationTransition()
        let module = AuthModule(transition: transition)
        open(module.view, transition: transition)
    }
}

