//
//  MovieDetailViewController.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieTaglineLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRunTimeLabel: UILabel!
    @IBOutlet weak var movieVoteCountLabel: UILabel!
    @IBOutlet weak var moviePopularityLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    var viewModel: MovieDetailViewModelProtocol! {
        didSet{
            viewModel.delegate = self
        }
    }
    private var movieDetail: MovieDetailModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
    
    private func setUIElements() {
        movieImageView.kf.indicatorType = .activity
        if let urlString = movieDetail?.backdropPath, let url = URL(string: urlString) {
            movieImageView.kf.setImage(with: url)
        }
        movieTitleLabel.text = movieDetail?.originalTitle
        movieTaglineLabel.text = movieDetail?.tagline
        movieOverviewLabel.text = movieDetail?.overview
        movieReleaseDateLabel.text = "Release Date: \(movieDetail?.releaseDateString ?? "")"
        movieRunTimeLabel.text = "Runtime: \(movieDetail?.runtime ?? 0) min"
        movieVoteCountLabel.text = "Vote count: \(movieDetail?.voteCount ?? 0)"
        moviePopularityLabel.text = "Popularity: \(movieDetail?.popularity ?? 0.0)"
        movieRatingLabel.text = "\(movieDetail?.voteAverage ?? 0.0)"
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieDetail?.castList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.castCell, for: indexPath)!
        let cast = movieDetail?.castList?[indexPath.row]
        cell.populateCell(with: cast!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 227)
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
        case .getMovieDetail(let movieDetail):
            self.movieDetail = movieDetail
            setUIElements()
            castCollectionView.reloadData()
            break
        case .showError(let errorMessage):
            showAlert(alertTitle: "Error", alertMessage: errorMessage)
            break
        }
    }
}
