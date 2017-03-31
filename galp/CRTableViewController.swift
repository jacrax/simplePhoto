//
//  CRTableViewController.swift
//  galp
//
//  Created by Carlos Pérez Azuara on 30/03/17.
//  Copyright © 2017 Carlos Pérez Azuara. All rights reserved.
//

import UIKit

protocol CameraTouchDelegate {
    func tapOnCamera()
}

protocol GalleryTouchDelegate{
    func tapOnGallery()
}
class CRTableViewController: UITableViewController {
    
    var folders = [Folder]()
    let cellIdentifier = "FolderCellIdentifier"
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        dummyData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    func dummyData(){
        for index in 1...4 {
            let folder = Folder(name: "folder\(index)")
            folders.append(folder)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CRTableViewCell
        let folder = folders[indexPath.row]
        cell.label.text = folder.name
        cell.cameraDelegate = self
        cell.galleryDelegate = self
        return cell
    }
    

    func saveImage (image: UIImage, imageName: String ) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        var result = false
        let fileName = self.getDocumentsURL().appendingPathComponent("\(imageName).png")
        do {
            try pngImageData?.write(to: fileName, options: .atomic)
            print("File: \(String(describing: pngImageData))")
            print("path: \(fileName)")
            result = true
        } catch {
            print(error)
            result = false
        }
        return result
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
        
        return documentsFolderPath.appending(filename)
    }
    
     func getDocumentsURL() -> URL{
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsUrl
    }

}

extension CRTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // SAVE TO FILE
            let date = Date()
            let imageName = "CRPA\(date.timeIntervalSinceNow.description)"
            saveImage(image: pickedImage, imageName: imageName)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension CRTableViewController: CameraTouchDelegate{
    func tapOnCamera() {
        print("tapOnCamera")
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
}

extension CRTableViewController: GalleryTouchDelegate{
    func tapOnGallery() {
        performSegue(withIdentifier: "gallery", sender: self)
    }
}
