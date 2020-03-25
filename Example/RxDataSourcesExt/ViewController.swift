//
//  ViewController.swift
//  RxDataSourcesExt
//
//  Created by MasterWatcher on 01/16/2020.
//  Copyright (c) 2020 MasterWatcher. All rights reserved.
//

import UIKit
import RxDataSourcesExt
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonCell = ButtonCellViewModel(title: "Button")
        let labelItem = LabelCellViewModel(title: "Test")
        let nestedSection = CollectionSectionModel(items: [
            TimeCellViewModel(title: "11:00"),
            TimeCellViewModel(title: "12:00"),
            TimeCellViewModel(title: "13:00"),
            TimeCellViewModel(title: "11:00"),
            TimeCellViewModel(title: "12:00"),
            TimeCellViewModel(title: "13:00")])
        let nestedSection2 = CollectionSectionModel(items: [
            TextCollectionCellViewModel(title: "test1"),
            TextCollectionCellViewModel(title: "test2"),
            TextCollectionCellViewModel(title: "test3"),
            TextCollectionCellViewModel(title: "test4"),
            TextCollectionCellViewModel(title: "test5"),
            TextCollectionCellViewModel(title: "test6")])
        let collectionItem = EmbedCollectionCellViewModel(id: "collection", nestedSections: [nestedSection])
        let collectionItem2 = EmbedCollectionCellViewModel(id: "collection1", nestedSections: [nestedSection2])
        let sections = [TableSectionModel(items: [collectionItem2, collectionItem, buttonCell, labelItem, labelItem, labelItem])]

        let director = TableDirector(animationConfiguration: .shift)

        Observable.of(sections)
            .bind(to: tableView.rx.items(director: director))
            .disposed(by: disposeBag)
        tableView.rx.setDelegate(director)
            .disposed(by: disposeBag)

        tableView.rx.viewModelSelected(LabelCellViewModel.self)
            .subscribe(onNext: { value in
                print(value.title)
            })
            .disposed(by: disposeBag)

        director.rx.cellCreated(ButtonCell.self) { $0.button.rx.tap }
            .subscribe(onNext: { _ in
                print("button tapped")
            })
            .disposed(by: disposeBag)

        director.rx.cellCreated(ButtonCell.self) { cell, viewModel in
            cell.button.rx.tap
                .map { viewModel.title }
            }
            .subscribe(onNext: { title in
                print("button tapped with title = \(title)")
            })
            .disposed(by: disposeBag)

        director.rx.cellCreated(ButtonCell.self) { cell, viewModel, indexPath in
            cell.button.rx.tap
                .map { indexPath.row }
        }
        .subscribe(onNext: { index in
            print("button tapped with index = \(index)")
        })
            .disposed(by: disposeBag)


        director.rx.nestedCellCreated(TextCollectionCell.self, in: EmbedCollectionCell.self) { $0.button.rx.tap }
            .subscribe(onNext: { value in
                print("tap")
            })
            .disposed(by: disposeBag)

        director.rx.nestedCellCreated(TextCollectionCell.self, in: EmbedCollectionCell.self) { cell, item in
            return cell.button.rx.tap
                .map { item.title }
        }
        .subscribe(onNext: { value in
            print("\(value) tap")
        })
        .disposed(by: disposeBag)

        director.rx.cellCreated(LabelCell.self)
            .subscribe(onNext: { cell, viewModel, _ in
                print("cell created \(viewModel.id)")
            })
            .disposed(by: disposeBag)
    }
}
