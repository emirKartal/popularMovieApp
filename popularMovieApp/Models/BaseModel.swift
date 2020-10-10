//
//  BaseModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: T?
}
