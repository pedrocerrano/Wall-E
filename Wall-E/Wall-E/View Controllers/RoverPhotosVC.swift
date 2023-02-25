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
    var photos: [Photo] = []
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        roverPhotoTableView.dataSource = self
        roverPhotoTableView.delegate = self
        configureDatePicker()
        fetchRoverInfo()
    }
    
    
    //MARK: - ACTIIONS
    @IBAction func searchPhotosButtonTapped(_ sender: Any) {
        photos.removeAll()
        fetchPhotos()
    }
    
//  The UI needs active dates limits from the Rovers because the photo dates may not overlap. Is there a way to set this in the date picker?
    
    //MARK: - FUNCTIONS
    func updateUI() {
        guard let roverNameReceiver = roverNameReciever else { return }
        DispatchQueue.main.async {
            self.roverBackgroundImageView.image         = UIImage(named: roverNameReceiver)
            self.roverNameLabel.text                    = "Mars Rover: \(roverNameReceiver)"
            self.instructionsLabel.text                 = "Please select a day within the Misson dates to view photos from Wall-E's friend: \(roverNameReceiver)"
        }
    }
    
    
    func configureDatePicker() {
        missionDatePicker.backgroundColor      = .systemTeal
        missionDatePicker.layer.cornerRadius   = 4
        missionDatePicker.layer.masksToBounds  = true

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
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let stringToMinDate = dateFormatter.date(from: rover.landingDate)
                        let stringToMaxDate = dateFormatter.date(from: rover.missionEndDate)
                        self.missionDatePicker.minimumDate = stringToMinDate
                        self.missionDatePicker.maximumDate = stringToMaxDate
                    }
                }
            }
        }
    }
    
    func fetchPhotos() {
        let onDate = missionDatePicker.date.asString()
        guard let rover = roverNameReciever else { return }
        PhotoController.fetchPhotos(forRover: rover, onDate: onDate) { photos in
            guard let photos = photos else { return }
            self.photos = photos
            DispatchQueue.main.async {
                self.roverPhotoTableView.reloadData()
            }
        }
    }
}


//MARK: - EXT: TableViewDataSource
extension RoverPhotosVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = roverPhotoTableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? RoverPhotoTableViewCell else { return UITableViewCell() }
        
        let index = photos[indexPath.row]
        cell.updateUI(forPhoto: index)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(photos[indexPath.row].photoPath)
    }
}
