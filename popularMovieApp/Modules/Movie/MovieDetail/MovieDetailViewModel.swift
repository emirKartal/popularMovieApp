//
//  MovieDetailViewModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    weak var delegate: MovieDetailViewModelDelegate?
    private var service: MovieService!
    private var movieId: Int
    
    init(isMock: Bool = false, id: Int) {
        self.service = MovieService(isMock: isMock)
        self.movieId = id
    }
    
    private func notify(_ output: MovieDetailViewModelOutput) {
        delegate?.handleMovieDetailViewModelOutput(output)
    }
}
