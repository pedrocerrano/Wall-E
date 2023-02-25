//
//  RoverVC.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import UIKit

class RoverVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var roverTableView: UITableView!
    
    
    //MARK: - PROPERTIES
    let roverNames = ["Curiosity", "Spirit", "Opportunity"]
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        roverTableView.dataSource = self
    }


    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRoverPhotosVC" {
            if let index = roverTableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? RoverPhotosVC {
                    let rover = roverNames[index.row]
                    destinationVC.roverNameReciever = rover
                }
            }
        }
    }
}


//MARK: - EXT: TableViewDataSource
extension RoverVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roverNames.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = roverTableView.dequeueReusableCell(withIdentifier: "roverCell", for: indexPath) as? RoverTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let rover = roverNames[indexPath.row]
        cell.updateUI(rover: rover)
        
        return cell
    }
}
