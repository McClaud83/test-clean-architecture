import RxSwift

class TableViewCell: UITableViewCell, Reusable {
    
    let bag = DisposeBag()
    private(set) var reuseBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reuseBag = DisposeBag()
    }
}
