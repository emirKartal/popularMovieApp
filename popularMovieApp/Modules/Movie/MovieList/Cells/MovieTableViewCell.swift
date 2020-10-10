//
//  MovieTableViewCell.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateCell(with movie: MovieModel) {
        var mutatableMovie = movie
        mutatableMovie.prepareForPresentations()
        movieTitleLabel.text = mutatableMovie.originalTitle
        movieImage.contentMode = .scaleAspectFill
        movieImage.kf.indicatorType = .activity
        if let urlString = mutatableMovie.posterPath {
            let url = URL(string: urlString)
            let resource = ImageResource(downloadURL: url!)
            movieImage.kf.setImage(
                with: resource,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: movieImage.bounds.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
        }
    }
}
