//
//  ImageCell.swift
//  ImageCell
//
//  Created by Roman Kiruxin on 17.02.2022.
//

import UIKit
import RealmSwift

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageWidth: Int?
    var imageHeight: Int?
    var dowloadDate: Date?
    
    func configure(with imageDetail: ImageDetail) {
        
        imageWidth = imageDetail.webformatWidth
        imageHeight = imageDetail.webformatWidth
        dowloadDate = Date()
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: imageDetail.webformatURL) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = UIImage(data: imageData)
            }
        }
    }
}
