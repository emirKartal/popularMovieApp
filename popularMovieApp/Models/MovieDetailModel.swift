//
//  MovieDetailModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct MovieDetailModel: Codable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var genres: [GenreModel]?
    var id: Int?
    var imdbId: String?
    var originaLanguage: String?
    var originalTitle: String?
    var overview: String
    var popularity: Double?
    var releaseDate: Date?
    var runtime: Int?
    var status: String?
    var title: String?
    var tagline: String
    var voteAverage: Double?
    var voteCount: Int?
    var releaseDateString: String?
    var castList: [CastModel]?
    
    mutating func prepareForPresentations(castList: [CastModel]) {
        self.releaseDateString = releaseDate?.convertToString(format: "dd.MM.yyyy")
        self.backdropPath = IMAGE_URL + (self.backdropPath ?? "")
        self.castList = castList
    }
}

