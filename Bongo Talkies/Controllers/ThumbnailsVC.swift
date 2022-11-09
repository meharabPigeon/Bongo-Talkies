//
//  ThumbnailsVC.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit

//MARK: Properties
class ThumbnailsVC: UIViewController {

    @IBOutlet weak var topRatedMovieCV: UICollectionView!
    var itemList: [ResultDetails] = [] {
        didSet {
            DispatchQueue.main.async {
                self.topRatedMovieCV.reloadData()
            }
        }
    }
    var currentIndex = 1
}

//MARK: Life cycle
extension ThumbnailsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieList(from: currentIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

//MARK: Api
extension ThumbnailsVC {
    
    func getMovieList(from page: Int) {
        RequestManager.getTopRatedMovieList(from: page) { object, error in
            DispatchQueue.main.async {
                if let success = object?.success, !success {
                    debugPrint("success = \(success)")
                } else {
                    self.itemList.append(contentsOf: object?.results ?? [])
                }
            }
        }
    }
}

//MARK: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ThumbnailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedMovieCell", for: indexPath) as? TopRatedMovieCell else {
            return UICollectionViewCell()
        }

        cell.configureCell(with: itemList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = itemList[indexPath.row].id else {
            return
        }
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC {
            vc.id = id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let leftAndRightPaddings: CGFloat = 20.0
        let numberOfItemsPerRow: CGFloat = 2.0

        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
        return CGSize(width: width, height: 2*width)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == itemList.count - 1 {
            currentIndex = currentIndex + 1
            getMovieList(from: currentIndex)
        }
    }
}

