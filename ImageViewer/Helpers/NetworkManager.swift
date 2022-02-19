//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Roman Kiruxin on 17.02.2022.
//

import UIKit

class NetworkManager {
    
    static private let apiKey = "25758500-d90c563180d84971f4ca5dc54"
    static private let search = "wolfs"
    static private let jsonUrl = "https://pixabay.com/api/?key=\(apiKey)&q=\(search)&image_type=photo"
    
    static func fetchData(completion: @escaping (Image, Bool) -> ()) {
        
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            guard let data = data else { return }
            
            do {
                let image = try JSONDecoder().decode(Image.self, from: data)
                let activityIndicatorStopAnimation = true
                
                DispatchQueue.main.async {
                    completion(image ?? Image.init(total: 0, totalHits: 0, hits: []), activityIndicatorStopAnimation)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
