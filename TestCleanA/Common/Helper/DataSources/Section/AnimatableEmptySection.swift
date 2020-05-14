import RxDataSources
import Core

struct AnimatableEmptySection<T: IdentifiableType & Equatable & ViewModel>: AnimatableSectionModelType {
    typealias Item = T

    var identity: String {
        return String(Date().timeIntervalSince1970)
    }

    var items: [T]

    init(items: [Item]) {
        self.items = items
    }

    init(original: AnimatableEmptySection<T>, items: [Item]) {
        self = original
        self.items = items
    }
}
