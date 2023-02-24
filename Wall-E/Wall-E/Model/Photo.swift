//
//  Photo.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import Foundation

class Photo {
    
    let roverName: String
    let earthDate: String
    let cameraName: String
    let photoPath: String
    let photoSolDate: Int
    
    enum Keys: String {
        case photoSolDate = "sol"
        case photoPath = "img_src"
        case earthDate = "earth_date"
        
        case camera
        case cameraName = "full_name"
    }
    
    init?(photoDictionary: [String : Any], roverName: String) {
        guard let earthDate = photoDictionary[Keys.earthDate.rawValue] as? String,
              let photoSolDate = photoDictionary[Keys.photoSolDate.rawValue] as? Int,
              let photoPath = photoDictionary[Keys.photoPath.rawValue] as? String,
              
              let cameraDict = photoDictionary[Keys.camera.rawValue] as? [String : Any],
              let cameraName = cameraDict[Keys.cameraName.rawValue] as? String else { return nil }
        
        self.roverName = roverName
        self.earthDate = earthDate
        self.cameraName = cameraName
        self.photoPath = photoPath
        self.photoSolDate = photoSolDate
    }
}