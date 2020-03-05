//
//  UITableView+Rx.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxCocoa
import RxSwift
import RxDataSources

extension Reactive where Base: UITableView {
    public func viewModelSelected<T>(_ modelType: T.Type) -> ControlEvent<T> {
         let source: Observable<T> = self.itemSelected.flatMap { [weak view = self.base as UITableView] indexPath -> Observable<T> in
            guard let view = view, let viewModel: T = view.rx.viewModel(at: indexPath) else {
                 return Observable.empty()
             }

             return Observable.just(viewModel)
         }

         return ControlEvent(events: source)
     }

    public func viewModel<T>(at indexPath: IndexPath) -> T? {
        guard let dataSource = self.dataSource.forwardToDelegate() as? SectionedViewDataSourceType else { return nil }
        guard let viewModel = try? dataSource.model(at: indexPath) else { return nil }
        return (viewModel as? AnyTableItem)
            .flatMap { $0.item as? T }
    }

    public func items<O: ObservableType>(director: TableDirector) -> (_ source: O) -> Disposable
        where O.E == [TableSectionModel] {
            items(dataSource: director.dataSource)
    }

    public var updateSize: Binder<IndexPath> {
        return Binder(self.base) { tableView, indexPath in
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }

    public func configureKeyboard() -> Disposable {
        return NotificationCenter.default.rx.notification(UIResponder.keyboardWillChangeFrameNotification)
            .subscribe(onNext: { note in
                if let newFrame = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    let insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0 )
                    self.base.contentInset = insets
                    self.base.scrollIndicatorInsets = insets
                }
            })
    }
}
