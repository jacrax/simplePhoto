//
//  CRCollectionViewController.swift
//  galp
//
//  Created by Carlos Pérez Azuara on 30/03/17.
//  Copyright © 2017 Carlos Pérez Azuara. All rights reserved.
//

import UIKit
import Photos
import SwiftPhotoGallery

private let reuseIdentifier = "Cell"

class CRCollectionViewController: UICollectionViewController {
    
    var imageArray = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        readFromFile()
        
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func readFromFile(){
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
        
            let pngFiles = directoryContents.filter{$0.pathExtension == "png"}
            for url in pngFiles{
                let image = UIImage(contentsOfFile: url.path)
                self.imageArray.append(image!)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        var image = cell.viewWithTag(1) as! UIImageView
        image.image = imageArray[indexPath.row]
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gallery = SwiftPhotoGallery(delegate: self as SwiftPhotoGalleryDelegate, dataSource: self)
        
        gallery.backgroundColor = UIColor.black
        gallery.pageIndicatorTintColor = UIColor.gray.withAlphaComponent(0.5)
        gallery.currentPageIndicatorTintColor = UIColor(red: 0.0, green: 0.66, blue: 0.875, alpha: 1.0)
        gallery.hidePageControl = false
        gallery.modalPresentationStyle = .overCurrentContext
        
        present(gallery, animated: true, completion: nil)

    }

}

extension CRCollectionViewController: SwiftPhotoGalleryDataSource {
    
    func numberOfImagesInGallery(gallery: SwiftPhotoGallery) -> Int {
        return imageArray.count
    }
    
    func imageInGallery(gallery: SwiftPhotoGallery, forIndex: Int) -> UIImage? {
        return  imageArray[forIndex] // UIImage(named: imageNames[forIndex])
    }
}

// MARK: SwiftPhotoGalleryDelegate Methods
extension CRCollectionViewController: SwiftPhotoGalleryDelegate {
    
    func galleryDidTapToClose(gallery: SwiftPhotoGallery) {
        dismiss(animated: true, completion: nil)
    }
}


extension CRCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3 - 1
    
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
}
