//
//  UIImageView+.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func load(with url: String?, placeHolder: UIImage? = UIImage(named: "image") , cop: ((_ image: UIImage?) -> Void)? = nil) {
        
        image = placeHolder
        
        guard let urlString = url else { return }
        guard let url = URL(string: urlString) else { return }
        
        let options: SDWebImageOptions = [.continueInBackground]
        
        sd_setImage(with: url, placeholderImage: placeHolder, options: options, progress: nil) {[weak self] (image, error, cache, url) in
            if image == nil {
                self?.image = placeHolder
                cop?(nil)
            } else {
                self?.image = image
                cop?(image)
            }
        }
    }
}
