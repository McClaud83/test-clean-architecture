import UIKit

protocol Closable: class {
  func close()
}

protocol RouterProtocol: class {
  associatedtype GenericController: UIViewController
  var viewController: GenericController? { get }

  func isTopViewController(_ aController: AnyClass) -> Bool
  func open(_ viewController: UIViewController, transition: Transition)
  func close()
}

class Router<GVC>: RouterProtocol, Closable where GVC: UIViewController {
  typealias GenericController = GVC

  weak var viewController: GenericController?
  var openTransition: Transition?
  
  func isTopViewController(_ aController: AnyClass) -> Bool {
      guard let viewController = self.viewController else { return false}
      if let presented = viewController.presentedViewController {
        return presented.isKind(of: aController)
      }
      if let topNavigation = viewController.navigationController?.topViewController {
        return topNavigation.isKind(of: aController)
      }
      return viewController.isKind(of: aController)
  }

  func open(_ viewController: UIViewController, transition: Transition) {
      transition.viewController = self.viewController
      transition.open(viewController)
  }

  func close() {
    guard let openTransition = openTransition else {
      assertionFailure("You should specify an open transition in order to close a module.")
      return
    }
    guard let viewController = viewController else {
      assertionFailure("Nothing to close.")
      return
    }
    openTransition.close(viewController)
  }
}
