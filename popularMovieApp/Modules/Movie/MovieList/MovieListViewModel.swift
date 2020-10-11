//
//  MovieListViewModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

final class MovieListViewModel: MovieListViewModelProtocol {
    private var service: MovieService!
    weak var delegate: MovieListViewModelDelegate?
    
    //Paging variables
    private var currentPage: Int!
    private var totalPages: Int!
    private var popularMovieList: [MovieModel] = []
    //-----
    
    init(isMock: Bool = false) {
        self.service = MovieService(isMock: isMock)
    }
    
    func getPopularMovies(page: Int) {
        notify(.isLoading(true))
        service.getPopularMovies(page: page) { [weak self] (result) in
            guard let self = self else {return}
            self.notify(.isLoading(false))
            switch result {
            case .success(let responseModel):
                let movieList = responseModel.results ?? []
                self.currentPage = page
                self.totalPages = responseModel.totalPages
                self.popularMovieList.append(contentsOf: movieList)
                self.notify(.showPopularMovieList(self.popularMovieList))
                break
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    func getPopularMoviesNextPage() {
        if currentPage <= totalPages {
            getPopularMovies(page: currentPage + 1)
        }
    }
    
    func selectMovie(id: Int) {
        let viewModel = MovieDetailViewModel(id: id)
        navigate(to: .toMovieDetail(viewModel))
    }
    
    func search(text: String) {
        service.getMultiSearchResults(text: text) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let searchResult):
                self.notify(.textSearched(searchResult))
                break
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    func selectPerson(id: Int) {
        let viewModel = PersonDetailViewModel(personId: id)
        navigate(to: .toPersonDetail(viewModel))
    }
    
    private func notify(_ output: MovieListViewModelOutput) {
        delegate?.handleMovieListViewModelOutput(output)
    }
    
    private func navigate(to route: MovieListRouter) {
        delegate?.navigate(to: route)
    }
}
