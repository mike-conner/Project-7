//
//  Endpoints.swift
//  MovieTime
//
//  Created by Mike Conner on 3/30/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

enum Endpoint: String {
    case genres = "genre/movie/list?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US"
    case actors = "person/popular?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US"
    case actorMovies = "/movie_credits?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US"
    case movies = "?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US"
}
