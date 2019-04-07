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
}

/*
extension MovieTimeManager {
    func getListOfGenres() {
        self.client.getListOfGenres { genres, error in
            if let genres = genres {
                self.apiReturnedGenres = genres
            }
        }
    }
}

extension MovieTimeManager {
    func getListOfActors() {
        self.client.getListOfActors { actors, error in
            if let actors = actors {
                self.apiReturnedActors = actors
            }
        }
    }
}

extension MovieTimeManager {
    func getListOfUserOneActorMovies(actorId: Int) {
        self.client.getListOfActorMovies(actorId: actorId) { actorMovies, error in
                if let actorMovies = actorMovies {
                    self.apiReturnedUserOneActorMovies.append(actorMovies)
                }
            }
    }
    
    func getListOfUserTwoActorMovies(actorId: Int) {
        self.client.getListOfActorMovies(actorId: actorId) { actorMovies, error in
            if let actorMovies = actorMovies {
                self.apiReturnedUserTwoActorMovies.append(actorMovies)
            }
        }
    }
    
}

extension MovieTimeManager {
    func getMovies(movieId: Int) {
        self.client.getMovies(movieId: movieId) { movie, error in
            if let movie = movie {
                self.finalMovies.append(movie)
            }
        }
    }
}*/

