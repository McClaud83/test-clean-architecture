import Foundation

protocol LoadingRoute {
    func showLoading()
}

extension LoadingRoute where Self: RouterProtocol {
    func showLoading() {
        let module = LoadingModule()
        let transition = WindowNavigationTransition()
        open(module.view, transition: transition)
    }
}
