//
//  Photo.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import Foundation

class Photo {
    
    let id: Int
    let earthDate: String
    let cameraName: String
    let photoPath: String
    let photoSolDate: Int
    
    init(id: Int, earthDate: String, cameraName: String, photoPath: String, photoSolDate: Int) {
        self.id           = id
        self.earthDate    = earthDate
        self.cameraName   = cameraName
        self.photoPath    = photoPath
        self.photoSolDate = photoSolDate
    }
}

extension Photo {
    
    enum Keys: String {
        case id
        case photoSolDate = "sol"
        case photoPath    = "img_src"
        case earthDate    = "earth_date"
        case camera
        case cameraName   = "full_name"
    }
    
    convenience init?(photoDictionary: [String : Any]) {
        guard let id = photoDictionary[Keys.id.rawValue] as? Int,
              let earthDate    = photoDictionary[Keys.earthDate.rawValue] as? String,
              let photoSolDate = photoDictionary[Keys.photoSolDate.rawValue] as? Int,
              let photoPath    = photoDictionary[Keys.photoPath.rawValue] as? String,
              let cameraDict   = photoDictionary[Keys.camera.rawValue] as? [String : Any],
              let cameraName   = cameraDict[Keys.cameraName.rawValue] as? String else { return nil }
        
        self.init(id: id, earthDate: earthDate, cameraName: cameraName, photoPath: photoPath, photoSolDate: photoSolDate)
    }
}
