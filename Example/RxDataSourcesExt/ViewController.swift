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
        let sections = [TableSectionModel(items: [buttonCell, labelItem, labelItem, labelItem])]

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
    }
}


