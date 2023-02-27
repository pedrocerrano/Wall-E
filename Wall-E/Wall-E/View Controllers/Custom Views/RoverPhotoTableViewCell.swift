//
//  RoverPhotoTableViewCell.swift
//  Wall-E
//
//  Created by iMac Pro on 2/25/23.
//

import UIKit

class RoverPhotoTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoIDLabel: UILabel!
    
    
    //MARK: - FUNCTIONS
    func updateUI(forPhoto photo: Photo) {
        cameraNameLabel.text = photo.cameraName
        photoIDLabel.text    = "ID: \(photo.id)"
        fetchPhoto(forPhoto: photo)
    }
    
    
    func fetchPhoto(forPhoto photo: Photo) {
        PhotoController.fetchPhoto(fromPhoto: photo) { photo in
            DispatchQueue.main.async {
                self.photoImageView.image = photo
            }
        }
    }
}
