//
//  GetActors.swift
//  MovieTime
//
//  Created by Mike Conner on 3/3/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation
/*
extension NetworkClient {
    func getListOfActors(completionHandler completion: @escaping (Actors?, Error?) -> Void) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            completion(nil, APIError.requestFailed)
            return
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(nil, APIError.requestFailed)
                    return
                }
                if httpResponse.statusCode == 200 {
                    do {
                        let results = try self.decoder.decode(Actors.self, from: data)
                        completion(results, nil)
                    } catch _ {
                        completion(nil, APIError.requestFailed)
                    }
                } else {
                    completion(nil, APIError.requestFailed)
                }
            } else if error != nil {
                completion(nil, APIError.requestFailed)
            }
        }
        task.resume()
    }
}
*/
