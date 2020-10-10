//
//  MovieDetailViewController.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var viewModel: MovieDetailViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    func handleMovieDetailViewModelOutput(_ output: MovieDetailViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            break
        case .updateTitle(let title):
            self.navigationItem.title = title
            break
        case .showError(let errorMessage):
            showAlert(alertTitle: "Error", alertMessage: errorMessage)
            break
        }
    }
}
