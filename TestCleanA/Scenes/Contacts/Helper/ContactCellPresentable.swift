import Domain

protocol ContactCellPresentable {
    var id: String { get }
    var name: String { get }
}


extension Domain.ContactItem: ContactCellPresentable {
    
}
