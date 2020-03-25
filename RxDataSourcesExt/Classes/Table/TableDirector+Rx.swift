//
//  TableDirector+Rx.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxSwift

extension Reactive where Base: TableDirector {

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

    public func cellSizeChanged<T: DisposableCell & SizeChangeableCell>(_ cellType: T.Type) -> Observable<IndexPath> {
        return base.cellConfigured
            .flatMap { data -> Observable<IndexPath> in
                Observable.just(data.cell)
                    .filterCast(T.self)
                    .flatMapAndDisposeInCell { $0.didChangeSize }
                    .map { data.indexPath }
        }
    }

    public func nestedCellCreated<T: DisposableCell, U, O: ObservableType, C: CollectionContainableCell & ConfigurableCell>(
        _ cellType: T.Type,
        in containerCellType: C.Type,
        closure: @escaping (T) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .filterCast(C.self)
                .flatMapAndDisposeInCell { data -> Observable<U> in
                    guard let collectionDirector = self.base.collectionDirectors[data.item.id] else { return .never() }
                    return collectionDirector.rx.cellCreated(T.self, closure: closure)
            }
    }

    public func nestedCellCreated<T: ConfigurableCell, U, O: ObservableType, C: CollectionContainableCell & ConfigurableCell>(
        _ cellType: T.Type,
        in containerCellType: C.Type,
        closure: @escaping (T, T.ViewModel) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .filterCast(C.self)
                .flatMapAndDisposeInCell { data -> Observable<U> in
                    guard let collectionDirector = self.base.collectionDirectors[data.item.id] else { return .never() }
                    return collectionDirector.rx.cellCreated(T.self, closure: closure)
            }
    }

    public func nestedCellCreated<T: ConfigurableCell, U, O: ObservableType, C: CollectionContainableCell & ConfigurableCell>(
        _ cellType: T.Type,
        in containerCellType: C.Type,
        closure: @escaping (T, T.ViewModel, IndexPath) -> O) -> Observable<U>
        where O.E == U {
            return base.cellConfigured
                .filterCast(C.self)
                .flatMapAndDisposeInCell { data -> Observable<U> in
                    guard let collectionDirector = self.base.collectionDirectors[data.item.id] else { return .never() }
                    return collectionDirector.rx.cellCreated(T.self, closure: closure)
            }
    }

    public func nestedViewModelSelected<T, C: CollectionContainableCell>(_ modelType: T.Type, in cellType: C.Type) -> Observable<T> {
        return base.cellConfigured
            .map { $0.cell }
            .filterCast(C.self)
            .flatMapAndDisposeInCell { $0.collectionView.rx.viewModelSelected(T.self) }
    }
}
