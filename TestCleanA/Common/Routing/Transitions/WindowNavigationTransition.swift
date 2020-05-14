import UIKit

class WindowNavigationTransition: NSObject {
    weak var viewController: UIViewController?
}

// MARK: - Transition

extension WindowNavigationTransition: Transition {
    
    func open(_ viewController: UIViewController) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let window = appDelegate.window
            else { return }
        
        let navCon = UINavigationController(rootViewController: viewController)
        navCon.isNavigationBarHidden = true
        
        window.rootViewController = navCon
        UIView.transition(with: window,
                          duration: Constants.AnimationDuration.short,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: { _ in
        })
        window.makeKeyAndVisible()
    }
    
    func close(_ viewController: UIViewController) { }
}
