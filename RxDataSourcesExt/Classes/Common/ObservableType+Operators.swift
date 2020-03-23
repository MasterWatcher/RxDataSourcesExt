//
//  ObservableType+Operators.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxSwift
import RxCocoa

extension ObservableType {
    func filterCast<T>(_ type: T.Type) -> Observable<T> {
        filter { $0 is T }
            .map { $0 as! T }
    }
}

extension ObservableType where E == CollectionConfigurationData {
    func filterCast<T: ConfigurableCell>(_ type: T.Type) -> Observable<ConfigurationData<T>> {
        filter { $0.cell is T && $0.item.item is T.ViewModel }
            .map { ConfigurationData(cell: $0.cell as! T, item: $0.item.item as! T.ViewModel, indexPath: $0.indexPath) }
    }
}

extension ObservableType where E == TableConfigurationData {
    func filterCast<T: ConfigurableCell>(_ type: T.Type) -> Observable<ConfigurationData<T>> {
        filter { $0.cell is T && $0.item.item is T.ViewModel }
            .map { ConfigurationData(cell: $0.cell as! T, item: $0.item.item as! T.ViewModel, indexPath: $0.indexPath) }
    }
}

extension ObservableType where E: DisposableCell {
    //Guarantee that any Observable from cell will be disposed by cell's disposeBag
    func flatMapAndDisposeInCell<U, O: ObservableType>(_ selector: @escaping (E) -> O) -> Observable<U> where O.E == U {
        flatMap { cell -> Observable<U> in
            let newObservable = selector(cell)
            let relay = PublishRelay<U>()
            newObservable.asObservable()
                .bind(to: relay)
                .disposed(by: cell.disposeBag)
            return relay.asObservable()
        }
    }
}

extension ObservableType where E: ConfigurationDataType, E.T: DisposableCell {
    //Guarantee that any Observable from cell will be disposed by cell's disposeBag
    func flatMapAndDisposeInCell<U, O: ObservableType>(_ selector: @escaping (E) -> O) -> Observable<U> where O.E == U {
        flatMap { data -> Observable<U> in
            let newObservable = selector(data)
            let relay = PublishRelay<U>()
            newObservable.asObservable()
                .bind(to: relay)
                .disposed(by: data.cell.disposeBag)
            return relay.asObservable()
        }
    }
}
