//
//  LoadingViewCapable.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import UIKit
import NVActivityIndicatorView

protocol LoadingViewCapable {
    func startLoading()
    func stopLoading()
}

extension LoadingViewCapable where Self: UIViewController  {
    func startLoading() {
        if activityIndicator == nil {
            let loader = createLoader()
            view.addSubview(loader)
            loader.center = view.center
            loader.startAnimating()
        }
        activityIndicator?.startAnimating()
    }
    
    func stopLoading() {
      let loader = view.subviews
            .filter{ $0 is NVActivityIndicatorView }
            .last as? NVActivityIndicatorView
        loader!.removeFromSuperview()
        loader!.stopAnimating()
    }
    
    private var activityIndicator: NVActivityIndicatorView? {
        view.subviews
            .filter { $0 is NVActivityIndicatorView }
            .first as? NVActivityIndicatorView
    }
    
    private func createLoader() -> NVActivityIndicatorView {
        NVActivityIndicatorView(frame: .init(x: 0, y: 0, width: 80, height: 80), type: .ballClipRotate, color: .systemBlue, padding: .zero)
    }
}
