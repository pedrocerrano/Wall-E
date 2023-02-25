//
//  RoverDetailVC.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import UIKit

class RoverDetailVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var roverBackgroundImageView: UIImageView!
    @IBOutlet weak var roverNameLabel: UILabel!
    @IBOutlet weak var activeFromLabel: UILabel!
    @IBOutlet weak var activeUntilLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    
    //MARK: - PROPERTIES
    var roverNameReciever: String? {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: - FUNCTIONS
    func updateUI() {
        guard let roverNameReceiver = roverNameReciever else { return }
        DispatchQueue.main.async {
            self.roverNameLabel.text            = "Mars Rover: \(roverNameReceiver)"
            self.roverBackgroundImageView.image = UIImage(named: roverNameReceiver)
            self.instructionsLabel.text         = "Please select a day within the Misson dates to view photos from Wall-E's friend: \(roverNameReceiver)"
        }
    }
}
