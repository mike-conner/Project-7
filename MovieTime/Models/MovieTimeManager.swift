//
//  MovieTimeManager.swift
//  MovieTime
//
//  Created by Mike Conner on 2/27/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

// This class is the object that manages the app.
class MovieTimeManager {
    
    var userOne: User = User() // create the first user
    var userTwo: User = User() // create the second user
    
    var userOneMakingSelections: Bool = true // keep track of who is making the current selections
    
    var apiReturnedGenres: Genres = Genres() // create an object that is an array of selected genres
    var apiReturnedActors: Actors = Actors() // create an object that is an array of selected actors
    var apiReturnedUserOneActorMovies: [ActorMovies] = [ActorMovies]() // create an array of movies that have the actors and genres that were selected for user one
    var apiReturnedUserTwoActorMovies: [ActorMovies] = [ActorMovies]() // same as above but for user two
    
    var movieListIds: [Int] = [Int]() // create an array to store the list of movie ID's from the API
    var finalMovies: [Movie] = [Movie]() // create an array to store the final list of movies returned from the logic that matches user one's and user two's selections
    
    // add a function to sort the final movies based on their vote average from the API
    func sortMovies() {
        var tempArray = [Movie]()
        tempArray = finalMovies.sorted(by: { $0.voteAverage > $1.voteAverage })
        finalMovies = tempArray
    }
}
