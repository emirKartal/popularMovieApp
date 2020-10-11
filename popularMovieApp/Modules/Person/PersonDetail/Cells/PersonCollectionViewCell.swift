//
//  PersonCollectionViewCell.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit
import Kingfisher

class PersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCell(with movie: CastModel) {
        movieNameLabel.text = movie.title
        moviePosterImageView.kf.indicatorType = .activity
        let moviePosterUrlString = IMAGE_URL + (movie.posterPath ?? "")
        if let url = URL(string: moviePosterUrlString) {
            let resource = ImageResource(downloadURL: url)
            moviePosterImageView.kf.setImage(
                with: resource,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: moviePosterImageView.bounds.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
        }
    }
    
}
