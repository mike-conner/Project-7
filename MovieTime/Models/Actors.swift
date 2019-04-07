//
//  Actors.swift
//  MovieTime
//
//  Created by Mike Conner on 2/26/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct Actors: Codable {
    var results: [Actor] = [Actor]()
}

struct Actor: Codable, Equatable {
    let id: Int
    let name: String
    let profilePath: String
}
