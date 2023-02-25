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
    @IBOutlet weak var photoSolLabel: UILabel!
    
    
    //MARK: - FUNCTIONS
    func updateUI() {
        cameraNameLabel.text = "(placeholder)"
        photoImageView.image = UIImage(named: "Wall-E")
        photoSolLabel.text   = "SOL date taken: 832"
    }
    
}
