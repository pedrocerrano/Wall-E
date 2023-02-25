//
//  Rover.swift
//  Wall-E
//
//  Created by iMac Pro on 2/25/23.
//

import Foundation

class Rover {
    
    let name: String
    let landingDate: String
    let missionEndDate: String
    let totalPhotos: Int
    
    enum Keys: String {
        case name
        case landingDate    = "landing_date"
        case missionEndDate = "max_date"
        case totalPhotos    = "total_photos"
    }
    
    init?(roverDictionary: [String : Any]) {
        guard let name           = roverDictionary[Keys.name.rawValue] as? String,
              let landingDate    = roverDictionary[Keys.landingDate.rawValue] as? String,
              let missionEndDate = roverDictionary[Keys.missionEndDate.rawValue] as? String,
              let totalPhotos    = roverDictionary[Keys.totalPhotos.rawValue] as? Int else { return nil }
        
        self.name           = name
        self.landingDate    = landingDate
        self.missionEndDate = missionEndDate
        self.totalPhotos    = totalPhotos
    }
}
