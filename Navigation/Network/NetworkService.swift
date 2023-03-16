//
//  NetworkService.swift
//  Navigation
//
//  Created by Игорь Скворцов on 13.03.2023.
//

import Foundation

enum AppConfiguration : String {
    case species = "https://swapi.dev/api/species/"
    case vehicles = "https://swapi.dev/api/vehicles/"
    case starships = "https://swapi.dev/api/starships/"
}

struct NetworkService {
    
    static func URLSessionDataTask(_ configuration: AppConfiguration) {
        if let url = URL(string: configuration.rawValue){
            
            let urlRequest = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                if let data = data {
                    print("A: \(String(data: data, encoding: .utf8) ?? "")")
                }
                if let response = response {
                    print("B header: allHeaderFields")
                    let array: [String: String]? = response.value(forKey: "allHeaderFields") as? [String : String]
                    if let array = array {
                        array.forEach { key, value in
                            print("\(key) : \(value)")
                        }
                    }
                    print("B status code: \(response.value(forKey: "statusCode") ?? "")")
                }
                if let error = error {
                    print("C: \(error.localizedDescription)")
                }
            }
            
            task.resume()
            
        }
    }
}
