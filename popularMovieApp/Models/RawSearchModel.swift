//
//  RawSearchModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct RawSearchModel: Codable {
    var mediaType: String?
    
    //Movie properties
    var popularity: Double?
    var posterPath: String?
    var id: Int?
    var originalTitle: String?
    var title: String?
    var voteAverage: Double?
    var releaseDate: Date?
    
    
    //Person Properties  -- id property is common for both
    var name: String?
    var profilePath: String?
    
    //presentation
    var releaseDateString: String?
}

struct SearchModel {
    var movies: [MovieModel]?
    var persons: [PersonModel]?
}



