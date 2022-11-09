//
//  TopRatedMovieCell.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit

//MARK: Properties
class TopRatedMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var releasedYear: UILabel!
}

//MARK: Methods
extension TopRatedMovieCell {
    
    func configureCell(with object: ResultDetails) {
        
        thumbnailView.clipsToBounds = true
        thumbnailView.contentMode = .scaleAspectFill
        if let url = object.getThumbnailUrl() {
            thumbnailView.loadImage(url: url, placeholder: UIImage.defaultImage())
        }
        
        if let title = object.title {
            self.title.text = title
        }
        
        if let year = object.getYearFromReleaseDate() {
            self.releasedYear.text = year
        }
    }
}
