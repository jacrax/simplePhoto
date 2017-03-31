//
//  GalleryViewController.swift
//  galp
//
//  Created by Carlos Pérez Azuara on 31/03/17.
//  Copyright © 2017 Carlos Pérez Azuara. All rights reserved.
//

import Foundation
import Foundation
import UIKit


class PortraitOnlyViewController: UIViewController {
    // MARK: Rotation Handling
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
}
