import Foundation
import Domain
import RxSwift
import Moya

class ContactsServiceImpl: Domain.ContactsService {
    let provider: MoyaProvider<ContactsAPI>
    
    init() {
        self.provider = MoyaProvider<ContactsAPI>(plugins: [
            AuthrisationTokePlugin()
        ])
    }

    func obtainContacts() -> Single<[ContactItem]> {
        return provider.rx.request(.contacts)
            .filterSuccessfulStatusCodes()
            .map(ContactsResponse.self)
            .map { response -> [ContactItem] in
                return response.feed.entry
                    .compactMap { entry -> ContactItem? in
                        return ContactItem(
                            id: entry.id.value,
                            name: entry.name.fullName.value ?? ""
                        )
                    }
            }
        .do(onSuccess: { items in
            print("items:", items.count)
        }, onError: {
            print("error:", $0)
        })
    }
}
