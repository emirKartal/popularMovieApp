//
//  MovieListBuilder.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation

final class MovieListBuilder {
    class func make(viewModel: MovieListViewModelProtocol)-> MainNavigationController {
        let navigationController = R.storyboard.movie.movieNavigation()!
        let vc = navigationController.viewControllers.first as! MovieListViewController
        vc.viewModel = viewModel
        return navigationController
    }
}
