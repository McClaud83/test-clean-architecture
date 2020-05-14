import RxDataSources
import Core

struct EmptySection<T: ViewModel>: SectionModelType {
    typealias Item = T

    var items: [T]

    init(items: [Item]) {
        self.items = items
    }

    init(original: EmptySection<T>, items: [Item]) {
        self = original
        self.items = items
    }
}
