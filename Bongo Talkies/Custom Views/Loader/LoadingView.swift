//
//  LoadingView.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit
import Lottie

//MARK: Properties
class LoadingView: UIView {
    
    @IBOutlet weak var animationView: AnimationView!
}

//MARK: Functions
extension LoadingView {
    
    func startAnimation() {
        animationView.alpha = 0.4
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        UIView.animate(withDuration: 0.3) {
            self.animationView.alpha = 1
        } completion: { (success) in
            self.animationView.play()
        }
    }
    
    func stopAnimation() {
        animationView.stop()
    }
}
