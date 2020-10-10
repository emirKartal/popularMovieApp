//
//  ErrorModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    var statusCode: Int?
    var statusMessage: String?
    var success: Bool?
}
