//
//  NetworkService.swift
//  Atmana_Ass
//
//  Created by Sai Naveen Katla on 23/03/21.
//

import Foundation
import Combine

final class NetworkService {
    
    private var urlComponentForCategories: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.chucknorris.io"
        components.path = "/jokes/categories"
        
        return components
    }
    
    func getCategories(completion: @escaping([String]) -> Void) {
        URLSession.shared.dataTask(with: urlComponentForCategories.url!) { (data, res, error) in
            if error == nil {
                let response = res as! HTTPURLResponse
                if response.statusCode == 200 {
                    if let safeData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String] {
                        completion(safeData)
                    }
                }
            }
        }.resume()
    }
    
    func getJokes(for category: String) -> AnyPublisher<JokeModel, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.chucknorris.io"
        components.path = "/jokes/random"
        components.queryItems = [URLQueryItem(name: "category", value: category)]
        
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: JokeModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

