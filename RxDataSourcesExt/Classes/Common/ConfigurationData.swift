//
//  ConfigurationData.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

struct ConfigurationData<T: ConfigurableCell>: ConfigurationDataType {
    let cell: T
    let item: T.ViewModel
    let indexPath: IndexPath
}
