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
    
    private let searchBar = UISearchBar()
    
    var viewModel: MovieListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    private var movieList: [MovieModel] = []
    private var searchResult: SearchModel?
    private var isUserSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPopularMovies(page: 1)
        setSearchBar()
        movieListTableView.tableFooterView = UIView()
    }
    
    private func setSearchBar() {
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isUserSearching ? 2 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isUserSearching {
            return section == 0 ? (searchResult?.movies?.count ?? 0) : (searchResult?.persons?.count ?? 0)
        }else {
            return movieList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isUserSearching {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath)!
                let movie = searchResult?.movies?[indexPath.row] ?? MovieModel()
                cell.populateCellForSearch(with: movie)
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.searchPersonCell, for: indexPath)!
                let person = searchResult?.persons?[indexPath.row] ?? PersonModel()
                cell.populateCell(with: person)
                return cell
            }
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.movieCell, for: indexPath)!
            let movie = movieList[indexPath.row]
            cell.populateCell(with: movie)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isUserSearching {
            if indexPath.section == 0 {
                let movie = searchResult?.movies?[indexPath.row] ?? MovieModel()
                guard let movieId = movie.id else {return}
                viewModel.selectMovie(id: movieId)
            }else {
                let person = searchResult?.persons?[indexPath.row] ?? PersonModel()
                guard let personId = person.id else {return}
                viewModel.selectPerson(id: personId)
            }
        }else {
            let movie = movieList[indexPath.row]
            guard let movieId = movie.id else {return}
            viewModel.selectMovie(id: movieId)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isUserSearching == false {
            if indexPath.row == (self.movieList.count - 1) {
                viewModel.getPopularMoviesNextPage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isUserSearching {
            return section == 0 ? "Movies" : "Persons"
        }else {
            return nil
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 2 {
            viewModel.search(text: searchText)
            self.isUserSearching = true
        }else {
            self.isUserSearching = false
            movieListTableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func handleMovieListViewModelOutput(_ output: MovieListViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            isLoading ? Spinner.start() : Spinner.stop()
            break
        case .showPopularMovieList(let list):
            self.movieList = list
            movieListTableView.reloadData()
            break
        case .textSearched(let searchResult):
            self.searchResult = searchResult
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
        case .toPersonDetail(let viewModel):
            let personDetailVC = PersonDetailBuilder.make(viewModel: viewModel)
            self.navigationController?.pushViewController(personDetailVC, animated: true)
            break
        }
    }
}
