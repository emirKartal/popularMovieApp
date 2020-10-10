//
//  ServiceProtocol.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import Moya

protocol ServiceProtocol: ErrorProtocol {
    var provider: MoyaProvider<MovieApi>! { get set }
    init(isMock:Bool)
}
extension ServiceProtocol {
    func moyaPlugins() -> [PluginType] {
        return [StatusCodePlugin()]
    }
}
