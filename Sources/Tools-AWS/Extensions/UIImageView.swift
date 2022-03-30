//
//  UIImageView.swift
//  ios-sunmobile
//
//  Created by Jeff DeWitte on 3/4/22.
//

import SDWebImage
import UIKit

extension UIImageView {
    func loadImage(stringURL: String) {
        sd_setImage(with: URL(string: stringURL), placeholderImage: #imageLiteral(resourceName: "Placeholder-image"))
    }
    
    func setActivityIndicator() {
        sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
    }
    
    func loadImage(data: Data) {
            self.image = UIImage(data: data)
    }
}
