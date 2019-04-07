//
//  Genres.swift
//  MovieTime
//
//  Created by Mike Conner on 2/26/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Genres: Decodable {
    var genres: [Genre] = [Genre]()
}

struct Genre: Decodable, Equatable {
    let id: Int
    let name: String
}
