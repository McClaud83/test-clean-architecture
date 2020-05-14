import RxDataSources
import Core

class RxTableViewReloadDataSource<
    Section: SectionModelType, Item>: RxTableViewSectionedReloadDataSource<Section>
where Section.Item == Item, Section.Item: ViewModel & ClassName {

    init(cellMap: CellMap) {
        super.init(configureCell: { (_, tableView, indexPath, cellViewModel) -> UITableViewCell in
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

class RxNoSectionTableViewReloadDataSource<
    Item: ClassName & ViewModel>: RxTableViewReloadDataSource<EmptySection<Item>, Item> {

}
