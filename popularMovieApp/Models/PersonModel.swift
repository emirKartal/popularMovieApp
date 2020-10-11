//
//  PersonModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

struct PersonModel: Codable {
    var birthday: Date?
    var knownForDepartment: String?
    var deathday: Date?
    var id: Int?
    var name: String?
    var biography: String?
    var popularity: Double?
    var placeOfBirth: String?
    var profilePath: String?
    var cast: [CastModel]?
    
    mutating func prepareForPresentation(castList: [CastModel]) {
        self.cast = castList
    }
}

