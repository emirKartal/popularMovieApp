//
//  MovieListViewController.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        viewModel.getPopularMovies(page: 1)
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func handleMovieListViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            break
        case .updateTitle(let title):
            self.navigationItem.title = title
            break
        case .showError(let errorMessage):
            break
        }
    }
}
