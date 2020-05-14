import RxDataSources
import Core

class RxTableViewAnimatedDataSource<
    Section: AnimatableSectionModelType, Item>: RxTableViewSectionedAnimatedDataSource<Section>
where Section.Item == Item, Section.Item: ViewModel & ClassName {

    init(cellMap: CellMap, animationConfiguration: AnimationConfiguration = .automatic) {
        super.init(animationConfiguration: animationConfiguration,
                   configureCell: { (_, tableView, indexPath, cellViewModel) -> UITableViewCell in
            let className = type(of: cellViewModel).className

            guard let identifier = cellMap[className] else {
                return UITableViewCell(style: .default, reuseIdentifier: nil)
            }

            let nib = UINib(nibName: identifier, bundle: .main)
            tableView.register(nib, forCellReuseIdentifier: identifier)
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)

            guard let cell = tableViewCell as? TableViewCell & CellAutoSetup else {
                return UITableViewCell(style: .default, reuseIdentifier: identifier)
            }

            cell.performAutoSetup(viewModel: cellViewModel)

            return cell
        })
    }
}

typealias DataSourceItem = ClassName & ViewModel & IdentifiableType & Equatable

class RxNoSectionTableViewAnimatedDataSource<
    Item: DataSourceItem>: RxTableViewAnimatedDataSource<AnimatableEmptySection<Item>, Item> {

}

extension AnimationConfiguration {

    static var automatic: AnimationConfiguration {
        return AnimationConfiguration(insertAnimation: .automatic,
                                      reloadAnimation: .automatic,
                                      deleteAnimation: .automatic)
    }
}
