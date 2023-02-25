//
//  Constants.swift
//  Wall-E
//
//  Created by iMac Pro on 2/24/23.
//

import Foundation

struct Constants {

    struct RoverPhotosURL {
        static let roverBaseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers"
        
        static let apiKeyKey    = "api_key"
        static let apiKeyValue  = "7wtYHMC3ZBN4ZvApj7Ujj6ZZZxV3gK4gAuDucGNK"

        static let photoBaseURL = "https://api.nasa.gov/mars-photos/api/v1/rovers/"
        static let photosPath   = "/photos"
        
        static let earthDateKey = "earth_date"
    }
}
