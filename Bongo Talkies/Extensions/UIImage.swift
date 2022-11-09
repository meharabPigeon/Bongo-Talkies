//
//  UIImage.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 8/11/22.
//

import UIKit
import SDWebImage

extension UIImage {
    
    static func defaultImage() -> UIImage? {
        return UIImage(named: "default_image")
    }
}

extension UIImageView {
    
    func loadImage(url: URL?, placeholder: UIImage? = nil) {
        DispatchQueue.main.async {
            if let url = url {
                self.sd_imageIndicator = SDWebImageActivityIndicator.gray
                self.sd_setImage(with: url, placeholderImage: placeholder, options: .highPriority, completed: nil)
            } else {
                self.image = UIImage.defaultImage()
            }
        }
    }
}
