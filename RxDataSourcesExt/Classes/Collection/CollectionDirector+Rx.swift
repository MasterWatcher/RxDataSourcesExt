//
//  CollectionDirector+Rx.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxSwift

extension Reactive where Base: CollectionDirector {

    public func cellCreated<T: ConfigurableCell>(_ cellType: T.Type) -> Observable<(T, T.ViewModel, IndexPath)> {
        return base.cellConfigured
            .filterCast(T.self)
            .map { ($0.cell, $0.item, $0.indexPath) }
    }

    public func cellCreated<T: DisposableCell,
        U,
        O: ObservableType>
        (_ cellType: T.Type, closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .map { $0.cell }
                .filterCast(T.self)
                .flatMapAndDisposeInCell(closure)
    }

    public func cellCreated<T: ConfigurableCell,
        U,
        O: ObservableType>(_ cellType: T.Type, closure: @escaping (T, T.ViewModel) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .filterCast(T.self)
                .flatMapAndDisposeInCell { closure($0.cell, $0.item) }
    }

    public func cellCreated<T: ConfigurableCell,
        U,
        O: ObservableType>(_ cellType: T.Type, closure: @escaping (T, T.ViewModel, IndexPath) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .filterCast(T.self)
                .flatMapAndDisposeInCell { closure($0.cell, $0.item, $0.indexPath) }
    }
}
