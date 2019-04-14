//
//  ActorMovies.swift
//  MovieTime
//
//  Created by Mike Conner on 3/3/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct ActorMovies: Codable {
    var cast: [ActorMovie] = [ActorMovie]()
}

struct ActorMovie: Codable {
    let id: Int
    let genreIds: [Int]
}
