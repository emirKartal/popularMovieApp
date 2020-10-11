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
    var gender: Int?
    
    var cast: [CastModel]?
    var birthdayString: String?
    var deathdayString: String?
    
    mutating func prepareForPresentation(castList: [CastModel]) {
        self.cast = castList
        self.birthdayString = birthday?.convertToString(format: "dd.MM.yyyy")
        self.deathdayString = deathday?.convertToString(format: "dd.MM.yyyy")
        self.profilePath = IMAGE_URL + (self.profilePath ?? "")
    }
}

