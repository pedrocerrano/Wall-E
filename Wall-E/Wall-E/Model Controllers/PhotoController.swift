//
//  PhotoController.swift
//  Wall-E
//
//  Created by iMac Pro on 2/25/23.
//

import Foundation

class PhotoController {
    
    static func fetchPhotos(forRover rover: String, onDate date: String, completion: @escaping ([Photo]?) -> Void) {
        
        guard let baseURL   = URL(string: Constants.RoverPhotosURL.photoBaseURL) else { completion(nil) ; return }
        var urlComponents   = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(rover.lowercased())
        urlComponents?.path.append(Constants.RoverPhotosURL.photosPath)
        
        let earthDateQuery  = URLQueryItem(name: Constants.RoverPhotosURL.earthDateKey, value: date)
        let apiQuery        = URLQueryItem(name: Constants.RoverPhotosURL.apiKeyKey, value: Constants.RoverPhotosURL.apiKeyValue)
        urlComponents?.queryItems = [earthDateQuery, apiQuery]
        
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Final Photo URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { photoData, response, error in
            if let error = error {
                print("Error in Photo Info request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Photo Info respones code: \(response.statusCode)")
            }
            
            guard let data = photoData else { completion(nil) ; return }
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any],
                   let photosArray = topLevel["photos"] as? [[String : Any]] {
                
                    let photos = photosArray.compactMap { Photo(photoDictionary: $0) }
                    completion(photos)
                }
                
            } catch {
                print("Unable to retrieve Photos data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
