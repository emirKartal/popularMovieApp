//
//  MoviePresentationModel.swift
//  popularMovieApp
//
//  Created by emir kartal on 10.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

final class MoviePresentation: NSObject {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var overview: String?
    var voteAverage: String?
    var posterImageString: String?
    var backdropImageString: String?
    var posterImage: UIImage?
    var backDropImage: UIImage?
    
    init(movie: MovieModel) {
        self.id = movie.id
        self.releaseDate = movie.releaseDate?.convertToString(format: "dd.MM.yyyy")
        self.overview = movie.overview
        self.voteAverage = "\(movie.voteAverage ?? 0)"
        self.posterImageString = IMAGE_URL + (movie.posterPath ?? "")
        self.backdropImageString = IMAGE_URL + (movie.backdropPath ?? "")
        self.title = movie.title
    }
    
//    func prepareMovieImages(url: String) {
//        let url = URL(string: url)
//        KingfisherManager.shared.retrieveImage(with: url) { result in
//            let image = try? result.get().image
//            if let image = image {
//                
//            }
//        }
//    }
}

