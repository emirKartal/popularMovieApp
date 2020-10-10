//
//  MovieDetailBuilder.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

final class MovieDetailBuilder {
    class func make(viewModel: MovieDetailViewModelProtocol)-> MovieDetailViewController {
        let vc = R.storyboard.movie.movieDetailViewController()!
        vc.viewModel = viewModel
        return vc
    }
}
