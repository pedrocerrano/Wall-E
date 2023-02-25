//
//  PhotoController.swift
//  Wall-E
//
//  Created by iMac Pro on 2/25/23.
//

import UIKit

class PhotoController {
    
    static func fetchPhotoMetaData(forRover rover: String, onDate date: String, completion: @escaping ([Photo]?) -> Void) {
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
                print("Error in Photo Meta Data request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Photo Meta Data response code: \(response.statusCode)")
            }
            
            guard let data = photoData else { completion(nil) ; return }
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any],
                   let photosArray = topLevel["photos"] as? [[String : Any]] {
                    
                    let photos = photosArray.compactMap { Photo(photoDictionary: $0) }
                    completion(photos)
                }
            } catch {
                print("Unable to retrieve Photo Meta Data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    static func fetchPhoto(fromPhoto photo: Photo, completion: @escaping (UIImage?) -> Void) {
        guard let photoBaseURL  = URL(string: photo.photoPath) else { completion(nil) ; return }
        let urlComponents       = URLComponents(url: photoBaseURL, resolvingAgainstBaseURL: true)
        
        guard let finalPhotoURL = urlComponents?.url else { completion(nil) ; return }
        print("Final Photo URL: \(finalPhotoURL)")
        
        URLSession.shared.dataTask(with: finalPhotoURL) { data, response, error in
            if let error = error {
                print("Error in Photo request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Photo response code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            let photo = UIImage(data: data)
            completion(photo)
        }.resume()
    }
}
