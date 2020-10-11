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
    func getPopularMovies(page: Int)
    func selectMovie(id: Int)
    func getPopularMoviesNextPage()
    func search(text: String)
    func selectPerson(id: Int)
}

protocol MovieListViewModelDelegate: class {
    func handleMovieListViewModelOutput(_ output: MovieListViewModelOutput)
    func navigate(to route: MovieListRouter)
}

enum MovieListViewModelOutput {
    case isLoading(Bool)
    case showPopularMovieList([MovieModel])
    case textSearched(SearchModel)
    case showError(String)
}

enum MovieListRouter {
    case toMovieDetail(MovieDetailViewModelProtocol)
    case toPersonDetail(PersonDetailViewModelProtocol)
}
