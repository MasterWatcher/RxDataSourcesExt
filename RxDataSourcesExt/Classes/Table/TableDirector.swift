//
//  TableConfigurationData.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

typealias TableConfigurationData = (cell: UITableViewCell, item: AnyTableItem, indexPath: IndexPath)

public class TableDirector: NSObject {

    typealias DataSource = RxTableViewSectionedAnimatedDataSource<TableSectionModel>

    var collectionDirectors = [String: CollectionDirector]()
    let cellConfigured = PublishRelay<TableConfigurationData>()
    private let animationConfiguration: AnimationConfiguration?
    private lazy var cellRegisterer = TableCellRegisterer()

    public init(animationConfiguration: AnimationConfiguration? = nil) {
        self.animationConfiguration = animationConfiguration
    }

    lazy var dataSource: DataSource = {
        let configureCell: DataSource.ConfigureCell = { [weak self] (_, tableView, indexPath, item) in
            self?.cellRegisterer.register(cellType: item.tableCellType, for: item.tableReuseIdentifier, in: tableView)
            let cell = tableView.dequeueReusableCell(withIdentifier: item.tableReuseIdentifier)!
            item.configure(cell)
            switch item.nestedType {
            case .none: break
            case let .collection(sections): self?.configureNestedCollection(with: cell, sections: sections, id: item.id)
            }
            self?.cellConfigured.accept((cell, item, indexPath))
            return cell
        }

        let titleForHeaderInSection: DataSource.TitleForHeaderInSection = { dataSource, index in
            let section = dataSource[index]
            return section.title
        }

        let dataSource = DataSource(animationConfiguration: animationConfiguration ?? AnimationConfiguration(),
                                    configureCell: configureCell,
                                    titleForHeaderInSection: titleForHeaderInSection)

        if animationConfiguration == nil {
            dataSource.decideViewTransition = { _,_,_  in RxDataSources.ViewTransition.reload }
        }
        return dataSource
    }()

    private func configureNestedCollection(with cell: UITableViewCell, sections: [CollectionSectionModel], id: String) {
        guard let cell = cell as? CollectionContainableCell else { return }
        let director = CollectionDirector(animationConfiguration: .fade)
        collectionDirectors[id] = director

        Observable.just(sections)
            .bind(to: cell.collectionView.rx.items(director: director))
            .disposed(by: cell.disposeBag)
        cell.collectionView.rx.setDelegate(director)
            .disposed(by: cell.disposeBag)
    }
}

extension TableDirector : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource[indexPath].rowHeight
    }
}
