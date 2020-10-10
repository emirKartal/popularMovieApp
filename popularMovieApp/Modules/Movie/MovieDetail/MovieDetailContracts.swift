//
//  MovieDetailContracts.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var delegate: MovieDetailViewModelDelegate? {get set}
    func load()
    func getMovieDetail()
    func getCast()
}

protocol MovieDetailViewModelDelegate: class {
    func handleMovieDetailViewModelOutput(_ output: MovieDetailViewModelOutput)
}

enum MovieDetailViewModelOutput {
    case isLoading(Bool)
    case updateTitle(String)
    case getMovieDetail(MovieDetailModel)
    case showError(String)
}
