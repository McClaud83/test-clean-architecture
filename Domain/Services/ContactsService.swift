import Foundation
import RxSwift

public protocol ContactsService {
    func obtainContacts() -> Single<[ContactItem]>
}
