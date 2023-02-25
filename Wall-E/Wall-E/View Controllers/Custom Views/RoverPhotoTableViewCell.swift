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
        photoIDLabel.text    = "Photo ID: \(photo.id)"
        if let imageURL = URL(string: photo.photoPath) {
            photoImageView.loadFromURL(url: imageURL)
        }
    }
}

//MARK: - EXT: UIImageView
extension UIImageView {
    func loadFromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
