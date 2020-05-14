import UIKit
import RxSwift
import RxCocoa

class ContactTableViewCell: TableViewCell, ReusableView, CellAutoSetup {
    @IBOutlet weak var nameLabel: UILabel!
    
    var viewModel: ContactCellViewModel?
    
    func setupInput(input: ContactCellViewModel.Output) {
        input.name
            .drive(nameLabel.rx.text)
            .disposed(by: reuseBag)
    }
    
    func setupOutput() {
        viewModel?.transform(.init(), outputHandler: setupInput(input:))
    }
}
