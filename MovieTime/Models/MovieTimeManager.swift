//
//  MovieTimeManager.swift
//  MovieTime
//
//  Created by Mike Conner on 2/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

class MovieTimeManager {
    
    var userOne: User = User()
    var userTwo: User = User()
    
    var userOneMakingSelections: Bool = true
    
    var apiReturnedGenres: Genres = Genres()
    var apiReturnedActors: Actors = Actors()
    var apiReturnedUserOneActorMovies: [ActorMovies] = [ActorMovies]()
    var apiReturnedUserTwoActorMovies: [ActorMovies] = [ActorMovies]()
    
    var movieListIds: [Int] = [Int]()
    var finalMovies: [Movie] = [Movie]()
    
    func sortMovies() {
        var tempArray = [Movie]()
        tempArray = finalMovies.sorted(by: { $0.popularity < $1.popularity })
        finalMovies = tempArray
    }
}
