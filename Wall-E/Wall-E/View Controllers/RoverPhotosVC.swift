//
//  RoverPhotosVC.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import UIKit

class RoverPhotosVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var roverBackgroundImageView: UIImageView!
    @IBOutlet weak var roverNameLabel: UILabel!
    @IBOutlet weak var activeFromLabel: UILabel!
    @IBOutlet weak var activeUntilLabel: UILabel!
    @IBOutlet weak var totalPhotosLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var missionDatePicker: UIDatePicker!
    @IBOutlet weak var roverPhotoTableView: UITableView!
    
    
    //MARK: - PROPERTIES
    var roverNameReciever: String? {
        didSet {
            updateUI()
        }
    }
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        roverPhotoTableView.dataSource = self
        fetchRoverInfo()
    }
    
    
    //MARK: - ACTIIONS
    @IBAction func searchPhotosButtonTapped(_ sender: Any) {
        
    }
    
//  The UI needs active dates limits from the Rovers because the photo dates may not overlap. Is there a way to set this in the date picker?
    
    //MARK: - FUNCTIONS
    func updateUI() {
        guard let roverNameReceiver = roverNameReciever else { return }
        DispatchQueue.main.async {
            self.roverBackgroundImageView.image         = UIImage(named: roverNameReceiver)
            self.roverNameLabel.text                    = "Mars Rover: \(roverNameReceiver)"
            self.instructionsLabel.text                 = "Please select a day within the Misson dates to view photos from Wall-E's friend: \(roverNameReceiver)"
            self.missionDatePicker.backgroundColor      = .systemTeal
            self.missionDatePicker.layer.cornerRadius   = 4
            self.missionDatePicker.layer.masksToBounds  = true
//            print("\n \(self.missionDatePicker.date)\n")
        }
        
    }
    
    func fetchRoverInfo() {
        guard let roverNameReceiver = roverNameReciever else { return }
        RoverController.fetchRoverInfo(withName: roverNameReceiver) { roversArray in
            guard let rovers = roversArray else { return }
            for rover in rovers {
                if rover.name == roverNameReceiver {
                    DispatchQueue.main.async {
                        self.totalPhotosLabel.text  = "\(rover.totalPhotos) total photos taken"
                        self.activeFromLabel.text   = "\(rover.landingDate): Landing Date"
                        self.activeUntilLabel.text  = "\(rover.missionEndDate): Mission End"
                    }
                }
            }
        }
    }
}


//MARK: - EXT: TableViewDataSource
extension RoverPhotosVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = roverPhotoTableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? RoverPhotoTableViewCell else { return UITableViewCell() }
        
        cell.updateUI()
        
        return cell
    }
}
