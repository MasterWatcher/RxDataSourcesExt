//
//  CollectionDIrector.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

typealias CollectionConfigurationData = (cell: UICollectionViewCell, item: AnyCollectionItem)

class CollectionDirector: NSObject {

    typealias DataSource = RxCollectionViewSectionedAnimatedDataSource<CollectionSectionModel>

    let cellConfigured = PublishRelay<CollectionConfigurationData>()
    private let animationConfiguration: AnimationConfiguration

    init(animationConfiguration: AnimationConfiguration = .none) {
        self.animationConfiguration = animationConfiguration
    }

    lazy var dataSource: DataSource = {
        let configureCell: DataSource.ConfigureCell = {(_, collectionView, indexPath, item) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.collectionReuseIdentifier, for: indexPath)
            item.configure(cell)
            self.cellConfigured.accept((cell, item))
            return cell
        }
        let dataSource = DataSource(animationConfiguration: animationConfiguration, configureCell: configureCell)
        return dataSource
    }()
}

extension CollectionDirector: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return dataSource[indexPath].itemSize
    }
}
