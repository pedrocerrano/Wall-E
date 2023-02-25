//
//  RoverTableViewCell.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import UIKit

class RoverTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var roverImageView: UIImageView!
    @IBOutlet weak var roverNameLabel: UILabel!
    
    
    //MARK: - FUNCTIONS
    func updateUI(rover: String) {
        roverImageView.image = UIImage(named: rover)
        roverNameLabel.text  = rover
    }
}
