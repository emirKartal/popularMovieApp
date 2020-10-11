//
//  PersonDetailViewController.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personBirthdayLabel: UILabel!
    @IBOutlet weak var personDeathdayLabel: UILabel!
    @IBOutlet weak var personPlaceOfBirth: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var personBioLabel: UILabel!
    @IBOutlet weak var moviesCollectionViewCell: UICollectionView!
    
    var viewModel: PersonDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    private var person: PersonModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
    }
    
    private func setUIElements() {
        personImageView.kf.indicatorType = .activity
        if let urlString = person?.profilePath, let url = URL(string: urlString) {
            personImageView.kf.setImage(with: url)
        }
        personBirthdayLabel.text = "Birthday: \(person?.birthdayString ?? "")"
        personDeathdayLabel.text = "Deathday: \(person?.deathdayString ?? "-")"
        personPlaceOfBirth.text = "PoB: \(person?.placeOfBirth ?? "")"
        popularityLabel.text = "Popularity: \(person?.popularity ?? 0.0)"
        gender.text = person?.gender == 1 ? "Gender: Female" : "Gender: Male"
        departmentLabel.text = "Department: \(person?.knownForDepartment ?? "")"
        personBioLabel.text = person?.biography
    }

}

extension PersonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return person?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.personMovieCell, for: indexPath)!
        let movie = person?.cast?[indexPath.row]
        cell.populateCell(with: movie!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedMovie = person?.cast?[indexPath.row] {
            viewModel.selectPersonMovie(movieId: selectedMovie.id!)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 250)
    }
}

extension PersonDetailViewController: PersonDetailViewModelDelegate {
    func handlePersonDetailViewModelOutput(_ output: PersonDetailViewModelOutput) {
        switch output {
        case .isLoading(let isLoading):
            break
        case .updateTitle(let title):
            self.navigationItem.title = title
            break
        case .showPersonDetail(let person):
            self.person = person
            setUIElements()
            moviesCollectionViewCell.reloadData()
            break
        case .showError(let errorMessage):
            showAlert(alertTitle: "Error", alertMessage: errorMessage)
            break
        }
    }
    
    func navigate(to route: PersonDetailRouter) {
        switch route {
        case .toMovieDetail(let viewModel):
            let movieDetailVC = MovieDetailBuilder.make(viewModel: viewModel)
            self.navigationController?.pushViewController(movieDetailVC, animated: true)
            break
        }
    }
    
}
