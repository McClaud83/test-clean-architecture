import Foundation
import RxSwift

public protocol ContactsUseCase {
    func obtainContacts() -> Single<[ContactItem]>
}

class ContactsUseCaseImpl: ContactsUseCase {
    private let contactsService: ContactsService
    
    init(contactsService: ContactsService) {
        self.contactsService = contactsService
    }
    
    func obtainContacts() -> Single<[ContactItem]> {
        return contactsService.obtainContacts()
    }
}
