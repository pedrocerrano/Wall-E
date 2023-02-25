//
//  RoverController.swift
//  Wall-E
//
//  Created by iMac Pro on 2/25/23.
//

import Foundation

class RoverController {
    
    static func fetchRoverInfo(withName: String, completion: @escaping ([Rover]?) -> Void) {
        
        guard let baseURL         = URL(string: Constants.RoverPhotosURL.roverBaseURL) else { completion(nil) ; return }
        var urlComponents         = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let apiQuery              = URLQueryItem(name: Constants.RoverPhotosURL.apiKeyKey, value: Constants.RoverPhotosURL.apiKeyValue)
        urlComponents?.queryItems = [apiQuery]
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Final Rover Info URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { roverData, response, error in
            if let error = error {
                print("Error in Rover Info request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Rover Info respones code: \(response.statusCode)")
            }
            
            guard let data = roverData else { completion(nil) ; return }
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any],
                   let roversArray = topLevel["rovers"] as? [[String : Any]] {
                    
                    let rovers = roversArray.compactMap { Rover(roverDictionary: $0) }
                    completion(rovers)
                }
            } catch {
                print("Unable to retreive Rover Info data: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
