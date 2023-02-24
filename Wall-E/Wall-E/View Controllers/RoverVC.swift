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
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        roverTableView.dataSource = self
        roverTableView.delegate = self
    }


    // MARK: - NAVIGATION
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}


extension RoverVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = roverTableView.dequeueReusableCell(withIdentifier: "roverCell", for: indexPath) as? RoverTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
}
