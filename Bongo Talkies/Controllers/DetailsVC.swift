//
//  DetailsVC.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit
import TTGTags

//MARK: Properties
class DetailsVC: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var tagView: TTGTextTagCollectionView!
    @IBOutlet weak var summary: UITextView!
    var id = Int()
}

//MARK: Life cycle
extension DetailsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieDetails(with: id)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

//MARK: Api
extension DetailsVC {
    
    func getMovieDetails(with id: Int) {
        LoadingManager.showProgress()
        RequestManager.getMovieDetails(with: id) { object, error in
            LoadingManager.hideProgress()
            DispatchQueue.main.async {
                guard let object else {
                    return
                }
                self.setUI(with: object)
            }
        }
    }
}

//MARK: UI
extension DetailsVC {
    
    func setUI(with object: MovieDetails) {
        if let url = object.getBackdropUrl() {
            backgroundImageView.loadImage(url: url, placeholder: UIImage.defaultImage())
        }
        
        if let url = object.getposterUrl() {
            posterImageView.alpha = 1
            posterImageView.loadImage(url: url, placeholder: UIImage.defaultImage())
        }
        
        if let mt = object.originalTitle {
            movieTitle.text = mt
        }
        
        if let year = object.getYearFromReleaseDate(),
            let runtime = object.getTimeFormatFromRunTime() {
            dateTime.text = "\(year) · \(runtime)"
        }
        
        if let overview = object.overview {
            summary.text = overview
        }
        
        tagView.alpha = 1
        tagView.backgroundColor = .clear
        
        let style = TTGTextTagStyle()
        style.backgroundColor = .clear
        style.cornerRadius = 6
        style.borderWidth = 1.0
        style.extraSpace = CGSize(width: 5.0, height: 2.0)
        
        if let genres = object.genres {
            for genre in genres {
                if let name = genre.name {
                    let tagContents = TTGTextTagStringContent(text: name, textFont: UIFont.systemFont(ofSize: 15), textColor: .white)
                    let textTag = TTGTextTag(content: tagContents, style: style)
                    tagView.addTag(textTag)
                }
            }
            tagView.reload()
        }
    }
}
