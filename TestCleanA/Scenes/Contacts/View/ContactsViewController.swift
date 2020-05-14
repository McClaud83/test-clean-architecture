import UIKit
import RxSwift
import RxCocoa
import RxViewController
import Core
import RxDataSources

class ContactsViewController: UIViewController, View, DIConfigurable {
    @IBOutlet weak var tableView: UITableView!
    
    internal var viewModel: ContactsViewModel!

    private let disposeBag = DisposeBag()
    private let signOutSubject = PublishSubject<Void>()
    
    private(set) var cellMap: CellMap = [:]
    
    private lazy var dataSource: RxTableViewSectionedReloadDataSource = {
        return RxNoSectionTableViewReloadDataSource<ContactCellViewModel>(cellMap: cellMap)
    }()
    
    required init(container: Container) {
        viewModel = container.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cellMap = configureCellMap()
        setupOutput()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func configureCellMap() -> CellMap {
        return [
            ContactCellViewModel.className: ContactTableViewCell.reuseID
        ]
    }
  
    func setupOutput() {
        let logoutTrigger = signOutSubject
            .asDriver(onErrorJustReturn: ())
        
        let startTrigger = self.rx.viewDidAppear.asDriver().mapTo(())
        
        let input = ContactsViewModel.Input(
            startTrigger: startTrigger,
            logoutTrigger: logoutTrigger,
            disposeBag: disposeBag
        )
        viewModel.transform(input, outputHandler: setupInput(input:))
    }
    
    func setupInput(input: ViewModelType.Output) {
        input.tableData.drive(tableView, dataSource, disposedBy: disposeBag)
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        title = "Contacts"
        
        let logoutButton = UIBarButtonItem(
            title: "SignOut",
            style: .plain,
            target: self,
            action: #selector(signOutTapAction))
        
        navigationItem.rightBarButtonItem = logoutButton
    }
 
    @objc
    func signOutTapAction() {
        self.signOutSubject.onNext(())
    }
}

extension ContactsViewController {
    struct Container {
        let viewModel: ContactsViewModel
    }
}
