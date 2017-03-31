//
//  CRTableViewCell.swift
//  galp
//
//  Created by Carlos Pérez Azuara on 30/03/17.
//  Copyright © 2017 Carlos Pérez Azuara. All rights reserved.
//

import UIKit

class CRTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!    
    @IBOutlet weak var folderImage: UIImageView!
    @IBOutlet weak var apertureImage: UIImageView!
    
    var cameraDelegate: CameraTouchDelegate?
    var galleryDelegate: GalleryTouchDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = true
        let cameraGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CRTableViewCell.tapOnCamera(_:)))
        let galleryGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CRTableViewCell.tapOnGallery(_:)))
        self.apertureImage.isUserInteractionEnabled = true
        self.folderImage.isUserInteractionEnabled = true
        self.apertureImage.addGestureRecognizer(cameraGestureRecognizer)
        self.folderImage.addGestureRecognizer(galleryGestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tapOnCamera(_ sender: UITapGestureRecognizer){
        print("taponImage")
        cameraDelegate?.tapOnCamera()
    }
    
    func tapOnGallery(_ sender: UITapGestureRecognizer){
        print("taponImage")
        galleryDelegate?.tapOnGallery()
    }

}
