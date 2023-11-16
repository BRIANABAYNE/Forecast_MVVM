//
//  NetworkingController.swift
//  Forecast_MVVM
//
//  Created by Karl Pfister on 2/13/22.
//

import Foundation

class NetworkingController {
    private static let baseURLString = "https://api.weatherbit.io"
    
    static func fetchDays(completion: @escaping (Result<TopLevelDictionary, ResultError>) -> Void) {
        guard let baseURL = URL(string:baseURLString) else {return}


        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/v2.0/forecast/daily"
        
        let apiQuery = URLQueryItem(name: "key", value: "8503276d5f49474f953722fa0a8e7ef8")
        let cityQuery = URLQueryItem(name: "city", value:"Salt Lake")
        let unitsQuery = URLQueryItem(name: "units", value: "I")
        urlComponents?.queryItems = [apiQuery,cityQuery,unitsQuery]
        
        guard let finalURL = urlComponents?.url else {return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { dayData, _, error in
            if let error = error {
                print("There was an error fetching the data. The url is \(finalURL), the error is \(error.localizedDescription)")
                completion(.failure(.invalidURL(finalURL)))
            }
            
            guard let data = dayData else {
                print("There was an error recieveing the data!")
                completion(.failure(.unableToDecode))
                return
            }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(TopLevelDictionary.self, from: data)
                completion(.success(topLevelDictionary))
            } catch {
                print("Error in Do/Try/Catch: \(error.localizedDescription)")
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}
