import RxCocoa
import RxDataSources
import Core

class ContactCellViewModel: ClassName, ViewModel {
    private let contact: ContactCellPresentable
    
    init(contact: ContactCellPresentable) {
        self.contact = contact
    }
    
    func transform(_ input: ContactCellViewModel.Input, outputHandler: (ContactCellViewModel.Output) -> Void) {
        let name = Driver.just(contact.name)
        
        let output = Output(name: name)
        
        outputHandler(output)
    }
}

extension ContactCellViewModel {
    struct Input {
        
    }
    struct Output {
        let name: Driver<String>
    }
}
