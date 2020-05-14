import RxSwift
import RxCocoa
import RxDataSources
import Core

typealias ItemType = IdentifiableType & ViewModel & Equatable

extension SharedSequence
where SharingStrategy == DriverSharingStrategy, Element: Collection, Element.Element: ItemType {
    
    typealias EmptyAnimatableSection = AnimatableEmptySection<Element.Element>
    
    func wrappedInAnimatableEmptySection() -> Driver<[EmptyAnimatableSection]> {
        return flatMapLatest({ element -> Driver<[EmptyAnimatableSection]> in
            guard let element = element as? [Element.Element] else {
                return Driver.empty()
            }
            return Driver.just([AnimatableEmptySection(items: element)])
        })
    }
}

extension SharedSequence
where SharingStrategy == DriverSharingStrategy, Element: Collection, Element.Element: ViewModel {
    
    func wrappedInEmptySection() -> Driver<[EmptySection<Element.Element>]> {
        return flatMapLatest({ element in
            guard let element = element as? [Element.Element] else {
                return Driver.empty()
            }
            return Driver.just([EmptySection(items: element)])
        })
    }
}


extension SharedSequence
where SharingStrategy == DriverSharingStrategy, Element: Collection, Element.Element: SectionModelType {
    
    /// Temporarily fixes RxCocoa problem
    /// https://github.com/ReactiveX/RxSwift/pull/2076
    func drive<DataSource>(_ tableView: UITableView,
                           _ dataSource: DataSource,
                           disposedBy bag: DisposeBag)
        where DataSource: RxTableViewDataSourceType & UITableViewDataSource, DataSource.Element == Element {
            DispatchQueue.main.async {
                self.drive(tableView.rx.items(dataSource: dataSource))
                    .disposed(by: bag)
            }
    }
}
