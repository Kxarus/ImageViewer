//
//  DetailImageViewController.swift
//  DetailImageViewController
//
//  Created by Roman Kiruxin on 17.02.2022.
//

import UIKit
import Foundation

class DetailImageViewController: UIViewController {

    @IBOutlet weak var fullImageView: UIImageView!
    
    var downloadImage: UIImage?
    var imageWidth: Int?
    var imageHeight: Int?
    var downloadDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillLayoutSubviews() {

        guard let width = imageWidth, let height = imageHeight else { return }
        fullImageView.frame = CGRect(x: 0,
                                     y: (Int(view.bounds.height) - height) / 2,
                                     width: width,
                                     height: height)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        setFullImageView()
        setupNavigationBar()
    }
    
    private func setFullImageView() {
        guard let image = downloadImage else { return }
        fullImageView.image = image
    }
    
    private func setupNavigationBar() {
        if let date = downloadDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
            title = dateFormatter.string(from: date)
        }
    }
    
}
