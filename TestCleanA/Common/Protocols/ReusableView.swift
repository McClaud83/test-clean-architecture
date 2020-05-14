import Foundation
import Core

protocol ReusableView: class {
    // swiftlint:disable type_name
    associatedtype VM: ViewModel
    // swiftlint:enable type_name
    
    var viewModel: VM? { get set }
    
    /**
     Реализуйте этот метод чтобы передать исходящие евенты от `View` во `ViewModel`.
     
     Вызовите этот метод из `viewDidLoad` или из `didSet` свойства `viewModel`.
     
     # Пример
     ```
     var viewModel: SomeViewModel { didSet { setupOutput() } }
     
     func setupOutput() {
     let input = SomeViewModel.Input()
     viewModel.transform(input, outputHandler: setupInput(input:))
     }
     ```
     */
    func setupOutput()
    
    /**
     Реализуйте этот метод чтобы забиндить результирующие евенты от `ViewModel` на `View`.
     
     Метод должен быть вызван посредствам `outputHandler` метода `transform(: outputHandler)` во `ViewModel`
     */
    func setupInput(input: VM.Output)
}
