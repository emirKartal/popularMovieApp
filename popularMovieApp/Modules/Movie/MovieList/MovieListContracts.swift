//
//  MovieContracts.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

protocol MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate? {get set}
    func load()
    func getPopularMovies(page: Int)
    func getPopularMoviesNextPage()
}

protocol MovieListViewModelDelegate: class {
    func handleMovieListViewModelOutput(_ output: MovieListViewModelOutput)
}

enum MovieListViewModelOutput {
    case isLoading(Bool)
    case updateTitle(String)
    case showPopularMovieList([MovieModel])
    case showError(String)
}
