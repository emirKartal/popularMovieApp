//
//  PersonDetailContracts.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

protocol PersonDetailViewModelProtocol {
    var delegate: PersonDetailViewModelDelegate? {get set}
    func load()
    func getPersonDetail()
    func getPersonCastMovies()
    func selectPersonMovie(movieId: Int)
}

protocol PersonDetailViewModelDelegate: class {
    func handlePersonDetailViewModelOutput(_ output: PersonDetailViewModelOutput)
    func navigate(to route: PersonDetailRouter)
}

enum PersonDetailViewModelOutput {
    case isLoading(Bool)
    case updateTitle(String)
    case showPersonDetail(PersonModel)
    case showError(String)
}

enum PersonDetailRouter {
    case toMovieDetail(MovieDetailViewModelProtocol)
}
