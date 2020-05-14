import Foundation

final class LoadingRouter: Router<LoadingViewController>, LoadingRouter.Routes {
    typealias Routes = AuthRoute & ContactsRoute
}
