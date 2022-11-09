//
//  LoadingManager.swift
//  Bongo Talkies
//
//  Created by Meharab Pigeon on 7/11/22.
//

import UIKit

class LoadingManager {

    static let shared = LoadingManager()
    
    var loadingView: LoadingView?
    var isLoading = false
    
    static func showProgress() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.delegate?.window else {
                return
            }
            
            if LoadingManager.shared.loadingView == nil {
                if let view = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)?.first as? LoadingView {
                    view.translatesAutoresizingMaskIntoConstraints = true
                    view.frame = window?.frame ?? CGRect.zero
                    LoadingManager.shared.loadingView?.tag = 101
                    LoadingManager.shared.loadingView = view
                }
            }
            
            if let view = LoadingManager.shared.loadingView, window?.viewWithTag(101) == nil {
                view.startAnimation()
                window?.addSubview(view)
                LoadingManager.shared.isLoading = true
            }
        }
    }
    
    static func hideProgress() {
        DispatchQueue.main.async {
            LoadingManager.shared.isLoading = false
            LoadingManager.shared.loadingView?.removeFromSuperview()
        }
    }
}
