//
//  MovieListViewController.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    private var movieList: [MovieModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        viewModel.getPopularMovies(page: 1)
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath)!
        let movie = movieList[indexPath.row]
        cell.populateCell(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movieList[indexPath.row]
        guard let movieId = movie.id else {return}
        viewModel.selectMovie(id: movieId)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.movieList.count - 1) {
            viewModel.getPopularMoviesNextPage()
        }
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
        case .showPopularMovieList(let list):
            self.movieList = list
            movieListTableView.reloadData()
            break
        case .showError(let errorMessage):
            showAlert(alertTitle: "Error", alertMessage: errorMessage)
            break
        }
    }
    
    func navigate(to route: MovieListRouter) {
        switch route {
        case .toMovieDetail(let viewModel):
            let movieDetailVC = MovieDetailBuilder.make(viewModel: viewModel)
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
            break
        }
    }
}
