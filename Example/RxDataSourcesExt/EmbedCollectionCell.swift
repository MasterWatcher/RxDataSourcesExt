//
//  EmbedCollectionCell.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 03/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSourcesExt

class EmbedCollectionCell: UITableViewCell, ConfigurableCell, CollectionContainableCell {

    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(width: 72, height: 72)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        flowLayout.minimumInteritemSpacing = 0.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()

    var disposeBag = DisposeBag()

    func configure(with viewModel: EmbedCollectionCellViewModel) {

    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}
