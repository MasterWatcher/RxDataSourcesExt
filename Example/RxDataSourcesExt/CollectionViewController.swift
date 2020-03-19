//
//  CollectionViewController.swift
//  RxDataSourcesExt_Example
//
//  Created by Goncharov Anton on 19/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSourcesExt

class CollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.minimumInteritemSpacing = 20
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            collectionView.collectionViewLayout = flowLayout
        }
    }
    let director = CollectionDirector()
    let disposeBag = DisposeBag()


    override func viewDidLoad() {
        super.viewDidLoad()

        let item1 = LabelCollectionCellViewModel(title: "item1", itemWidth: .relative(percentage: 50))
        let item2 = LabelCollectionCellViewModel(title: "item2", itemWidth: .relative(percentage: 50))
        let item3 = LabelCollectionCellViewModel(title: "item3 test", itemWidth: .relative(percentage: 100))
        let sections: [CollectionSectionModel] = [
            CollectionSectionModel(items: [item1, item2, item3])
        ]

        Observable.just(sections)
            .bind(to: collectionView.rx.items(director: director))
            .disposed(by: disposeBag)
        collectionView.rx.setDelegate(director)
            .disposed(by: disposeBag)
    }
}
