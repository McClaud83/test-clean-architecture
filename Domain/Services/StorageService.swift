import Foundation
import RxSwift

public protocol StorageService {
    func obtainUserToken() -> Single<String?>
    func storeUserToken(_ token: String?) -> Single<Void>
}
