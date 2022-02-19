//
//  ImageCollectionViewController.swift
//  ImageCollectionViewController
//
//  Created by Roman Kiruxin on 17.02.2022.
//

import UIKit
import RealmSwift

class ImageCollectionViewController: UICollectionViewController {
    
    private let reuseIdentifier = "imageItem"
    
    var dataImage = Image(total: 0, totalHits: 0, hits: [])
    var activityIndicatorStopAnimation = false
    
    var imagesLists: Results<ImageList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.showsVerticalScrollIndicator = false
        
        imagesLists = realm.objects(ImageList.self)
        
        NetworkManager.fetchData { image, activityIndicatorStopAnimation in
            
            self.dataImage = image
            self.activityIndicatorStopAnimation = activityIndicatorStopAnimation
            self.collectionView.reloadData()
            
            let newImageList = StorageManager.createImageList(images: image)
            let currentList = self.imagesLists.first
            
            if self.imagesLists.count == 0 {
                DispatchQueue.main.async {
                    StorageManager.saveImagesList(images: newImageList)
                }
            } else {
                DispatchQueue.main.async {
                    StorageManager.editList(imagesList: currentList!, newImageList: newImageList)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "imageItem" {
            guard let detailImageVC = segue.destination as? DetailImageViewController else { return }
            guard let cell = sender as? ImageCell else { return }
            detailImageVC.downloadImage = cell.imageView.image
            detailImageVC.imageWidth = cell.imageWidth
            detailImageVC.imageHeight = cell.imageHeight
            detailImageVC.downloadDate = cell.dowloadDate
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return imagesLists.first?.images.count ?? dataImage.hits.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        
        if self.imagesLists.count == 0 {
            cell.configure(with: dataImage.hits[indexPath.item])
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            cell.activityIndicator.hidesWhenStopped = true
        } else {
            cell.activityIndicator.isHidden = true
            cell.imageHeight = imagesLists.first!.images[indexPath.item].webformatHeight
            cell.imageWidth = imagesLists.first!.images[indexPath.item].webformatWidth
            cell.imageView.image = UIImage(data: imagesLists.first!.images[indexPath.item].imageFromWebUrl)
            cell.dowloadDate = imagesLists.first!.images[indexPath.item].date
        }

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions -> UIMenu? in
            
            let action = UIAction(title: "Информация об изображении", image: UIImage(systemName: "info.circle")) { action in
                
                guard let imageList = self.imagesLists.first else { return }
                
                let detailImage = """
                    id:\(imageList.images[indexPath.item].id)
                    type:\(imageList.images[indexPath.item].type)
                    tags:\(imageList.images[indexPath.item].tags)
                    webformatWidth:\(imageList.images[indexPath.item].webformatWidth)
                    webformatHeight:\(imageList.images[indexPath.item].webformatHeight)
                    downloads:\(imageList.images[indexPath.item].downloads)
                    user:\(imageList.images[indexPath.item].user)
                    """
                
                let infoAlert = UIAlertController(title: "Info", message: detailImage, preferredStyle: .alert)
                let OK = UIAlertAction(title: "OK", style: .cancel)
                
                infoAlert.addAction(OK)
                self.present(infoAlert, animated: true,completion: nil)
            }
            return UIMenu(children: [action])
        }
        return configuration
    }
}
