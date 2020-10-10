//
//  CastCollectionViewCell.swift
//  popularMovieApp
//
//  Created by emir kartal on 11.10.2020.
//  Copyright © 2020 emir. All rights reserved.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castCharacterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCell(with cast: CastModel) {
        castNameLabel.text = cast.name
        castCharacterNameLabel.text = cast.character
        castImageView.kf.indicatorType = .activity
        let castImageUrl = IMAGE_URL + (cast.profilePath ?? "")
        if let url = URL(string: castImageUrl) {
            let resource = ImageResource(downloadURL: url)
            castImageView.kf.setImage(
                with: resource,
                placeholder: nil,
                options: [
                    .processor(DownsamplingImageProcessor(size: castImageView.bounds.size)),
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ])
        }
    }
}
