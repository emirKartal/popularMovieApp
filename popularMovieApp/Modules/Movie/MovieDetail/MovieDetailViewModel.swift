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
    private var movieDetail: MovieDetailModel!
    
    init(isMock: Bool = false, id: Int) {
        self.service = MovieService(isMock: isMock)
        self.movieId = id
    }
    
    func load() {
        getMovieDetail()
    }
    
    func getMovieDetail() {
        notify(.isLoading(true))
        service.getMovieDetail(id: self.movieId) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(let movieDetail):
                self.movieDetail = movieDetail
                self.notify(.updateTitle(movieDetail.originalTitle ?? ""))
                self.getCast()
                break
            case .failure(let error):
                self.notify(.isLoading(false))
                self.notify(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    func getCast() {
        service.getCast(id: self.movieId) { [weak self](result) in
            guard let self = self else {return}
            self.notify(.isLoading(false))
            switch result {
            case .success(let castList):
                self.movieDetail.prepareForPresentations(castList: castList)
                self.notify(.getMovieDetail(self.movieDetail))
                break
            case .failure(let error):
                self.notify(.showError(error.localizedDescription))
                break
            }
        }
    }
    
    func personSelected(personId: Int) {
        let viewModel = PersonDetailViewModel(personId: personId)
        navigate(to: .toPersonDetail(viewModel))
    }
    
    private func notify(_ output: MovieDetailViewModelOutput) {
        delegate?.handleMovieDetailViewModelOutput(output)
    }
    
    private func navigate(to route: MovieDetailRouter) {
        delegate?.navigate(to: route)
    }
}
