//
//  AnimationConfiguration+Extensions.swift
//  RxDataSourcesExt
//
//  Created by Goncharov Anton on 16/01/2020.
//

import RxDataSources

extension AnimationConfiguration {

    public static var none: AnimationConfiguration {
        AnimationConfiguration(insertAnimation: .none,
                               reloadAnimation: .none,
                               deleteAnimation: .none)
    }

    public static var fade: AnimationConfiguration {
           AnimationConfiguration(insertAnimation: .fade,
                                  reloadAnimation: .fade,
                                  deleteAnimation: .fade)
       }

    public static var shift: AnimationConfiguration {
        AnimationConfiguration(insertAnimation: .top,
                               reloadAnimation: .fade,
                               deleteAnimation: .top)
    }
}
