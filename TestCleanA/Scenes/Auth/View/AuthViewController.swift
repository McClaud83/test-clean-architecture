import UIKit
import RxSwift
import RxCocoa
import Core

class AuthViewController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    
    private let viewModel: AuthViewModel
    private let disposeBag = DisposeBag()
    
    required init(container: Container) {
        self.viewModel = container.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutput()
    }
    
    internal func setupOutput() {
        let signInTrigger = signInButton.rx.tap
            .asDriver()
            .mapTo(self as UIViewController)
        
        let vmInput = AuthViewModel.Input(
            disposeBag: disposeBag,
            signInTrigger: signInTrigger
        )
        viewModel.transform(vmInput, outputHandler: setupInput(input:))
    }
    
    func setupInput(input: AuthViewModel.Output) {
    }
    
}

extension AuthViewController {
    struct Container {
        let viewModel: AuthViewModel
    }
}
