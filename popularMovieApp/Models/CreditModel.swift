//
//  CreditModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct CreditModel: Codable {
    var id: Int?
    var cast: [CastModel]?
}
