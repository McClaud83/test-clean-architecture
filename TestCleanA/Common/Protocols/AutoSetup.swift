import Foundation
import Core

protocol AutoSetup {
    var shouldSetupAutomatically: Bool { get }
    
    func performAutoSetup()
}

extension AutoSetup where Self: View {
    
    var shouldSetupAutomatically: Bool {
        return true
    }
    
    func performAutoSetup() {
        setupOutput()
    }
}

protocol CellAutoSetup {
    var shouldSetupAutomatically: Bool { get }
    
    func performAutoSetup<VM: ViewModel>(viewModel: VM)
}

extension CellAutoSetup where Self: ReusableView {
    
    var shouldSetupAutomatically: Bool {
        return true
    }
    
    func performAutoSetup<VM: ViewModel>(viewModel: VM) {
        if let viewModel = viewModel as? Self.VM {
            self.viewModel = viewModel
            setupOutput()
        }
    }
}
