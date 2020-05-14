import Foundation
import Domain
import RxSwift

class StorageServiceImpl: Domain.StorageService {
    func obtainUserToken() -> Single<String?> {
        let key = Constants.UserDefaultsKeys.authToken.rawValue
        let storedValue = UserDefaults.standard.string(forKey: key)
        return Single.just(storedValue)
    }
    
    func storeUserToken(_ token: String?) -> Single<Void> {
        let key = Constants.UserDefaultsKeys.authToken.rawValue
        UserDefaults.standard.setValue(token, forKey: key)
        return Single.just(())
    }
}
