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
    
    init(isMock: Bool = false) {
        self.service = MovieService(isMock: isMock)
    }
    
    func load() {
        notify(.updateTitle("Popular Movies"))
    }
    
    func getPopularMovies(page: Int) {
        notify(.isLoading(true))
        service.getPopularMovies(page: page) { [weak self] (result) in
            guard let self = self else {return}
            self.notify(.isLoading(false))
            switch result {
            case .success(let responseModel):
                print(responseModel.totalPages)
                print(responseModel.results?.count)
                
                break
            case .failure(let error):
                break
            }
        }
    }
    
    private func notify(_ output: MovieListViewModelOutput) {
        delegate?.handleMovieListViewModelOutput(output)
    }
}
