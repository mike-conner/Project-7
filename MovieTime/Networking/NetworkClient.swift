//
//  NetworkClient.swift
//  MovieTime
//
//  Created by Mike Conner on 2/26/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

class NetworkClient {
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: .default)
    }
}

struct APIManager<T: Decodable> {
    static func getAll(url: URL, completion: @escaping (T?, Error?) -> Void) {
        let client = NetworkClient(configuration: .default)
        
        client.decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let request = URLRequest(url: url)
    
        let task = client.session.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, APIError.responseUnsuccessful)
                    return
                }
                if httpResponse.statusCode == 200 {
                    do {
                        let results = try client.decoder.decode(T.self, from: data)
                        completion(results, nil)
                    } catch _ {
                        completion(nil, APIError.jsonParsingFailure)
                    }
                } else {
                    completion(nil, APIError.requestFailed)
                }
            } else if error != nil {
                completion(nil, APIError.invalidData)
            }
        }
    task.resume()
    }
}

