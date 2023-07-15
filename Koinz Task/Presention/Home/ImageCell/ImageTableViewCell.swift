//
//  ImageTableViewCell.swift
//  Koinz Task
//
//  Created by Youssef on 15/07/2023.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flickrImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func config(model: FlickrPictureModel) {
        switch model.image {
        case .url(let url):
            flickrImageView.load(with: url)
        case .imageName(let imageName):
            flickrImageView.image = .init(named: imageName)
        }
    }
}
