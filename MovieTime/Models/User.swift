//
//  User.swift
//  MovieTime
//
//  Created by Mike Conner on 2/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

struct User {
    var areUserSelectionsComplete: Bool = false
    
    var userSelectedGenres: [Genre] = [Genre]()
    var userSelectedActors: [Actor] = [Actor]()
    
    var movieIdListAfterGenreSort: [Int] = [Int]()
}
