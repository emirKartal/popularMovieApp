//
//  MovieModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct MovieModel: Codable {
    var popularity: Double?
    var voteCount: Double?
    var video: Bool?
    var posterPath: String?
    var id: Int?
    var adult: Bool?
    var backdropPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var title: String?
    var voteAverage: Double?
    var overview: String?
    var releaseDate: Date?
}

