import UIKit
import RxSwift
import RxCocoa
import Core

final class LoadingViewController: UIViewController, View, DIConfigurable {
    private let disposeBag = DisposeBag()
  
    internal var viewModel: LoadingViewModel!
  
    required init(container: Container) {
        viewModel = container.viewModel
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
        let startTrigger = self.rx
            .viewDidAppear
            .asDriver()
            .mapTo(())
        
        let controller = Driver.just(self as UIViewController)
        
        let vmInput = LoadingViewModel.Input(
            startTrigger: startTrigger,
            controller: controller,
            disposeBag: disposeBag
        )
        viewModel.transform(vmInput, outputHandler: setupInput(input:))
    }

    func setupInput(input: LoadingViewModel.Output) {
    }
}

extension LoadingViewController {
    struct Container {
        let viewModel: LoadingViewModel
    }
}
