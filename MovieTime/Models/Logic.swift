//
//  Logic.swift
//  MovieTime
//
//  Created by Mike Conner on 3/3/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import Foundation

extension MovieTimeManager {
    
    func determineMovieMatches() {
        removeMoviesNotMatchingSelectedGenresForUserOne()
        removeMoviesNotMatchingSelectedGenresForUserTwo()
        compareSortedMovieLists()
    }
    
    func removeMoviesNotMatchingSelectedGenresForUserOne() {
        var selectedGenreIndex: Int = 0
        var selectedActorIndex: Int = 0
        var selectedActorMovieIndex: Int = 0
        var selectedActorMovieGenreIndex: Int = 0
        
        let totalNumberOfSelectedGenres = userOne.userSelectedGenres.count
        let totalNumberOfSelectedActors = userOne.userSelectedActors.count
        
        while selectedGenreIndex < totalNumberOfSelectedGenres {
            while selectedActorIndex < totalNumberOfSelectedActors {
                if apiReturnedUserOneActorMovies.count != 0 {
                    let totalNumberOfSelectedActorMovies = apiReturnedUserOneActorMovies[selectedActorIndex].cast.count
                    while selectedActorMovieIndex < totalNumberOfSelectedActorMovies {
                        let totalNumberOfSelectedActorMoviesGenres = apiReturnedUserOneActorMovies[selectedActorIndex].cast[selectedActorMovieIndex].genreIds.count
                        while selectedActorMovieGenreIndex < totalNumberOfSelectedActorMoviesGenres {
                            if userOne.userSelectedGenres[selectedGenreIndex].id == apiReturnedUserOneActorMovies[selectedActorIndex].cast[selectedActorMovieIndex].genreIds[selectedActorMovieGenreIndex] {
                                userOne.movieIdListAfterGenreSort.append(apiReturnedUserOneActorMovies[selectedActorIndex].cast[selectedActorMovieIndex].id)
                            }
                            selectedActorMovieGenreIndex += 1
                        }
                        selectedActorMovieGenreIndex = 0
                        selectedActorMovieIndex += 1
                    }
                }
                selectedActorMovieIndex = 0
                selectedActorIndex += 1
            }
            selectedActorIndex = 0
            selectedGenreIndex += 1
        }
    }
    
    func removeMoviesNotMatchingSelectedGenresForUserTwo() {
        var selectedGenreIndex: Int = 0
        var selectedActorIndex: Int = 0
        var selectedActorMovieIndex: Int = 0
        var selectedActorMovieGenreIndex: Int = 0
        
        let totalNumberOfSelectedGenres = userTwo.userSelectedGenres.count
        let totalNumberOfSelectedActors = userTwo.userSelectedActors.count
        
        while selectedGenreIndex < totalNumberOfSelectedGenres {
            while selectedActorIndex < totalNumberOfSelectedActors {
                if apiReturnedUserTwoActorMovies.count != 0 {
                    let totalNumberOfSelectedActorMovies = apiReturnedUserTwoActorMovies[selectedActorIndex].cast.count
                    while selectedActorMovieIndex < totalNumberOfSelectedActorMovies {
                        let totalNumberOfSelectedActorMoviesGenres = apiReturnedUserTwoActorMovies[selectedActorIndex].cast[selectedActorMovieIndex].genreIds.count
                        while selectedActorMovieGenreIndex < totalNumberOfSelectedActorMoviesGenres {
                            if userTwo.userSelectedGenres[selectedGenreIndex].id == apiReturnedUserTwoActorMovies[selectedActorIndex].cast[selectedActorMovieIndex].genreIds[selectedActorMovieGenreIndex] {
                                userTwo.movieIdListAfterGenreSort.append(apiReturnedUserTwoActorMovies[selectedActorIndex].cast[selectedActorMovieIndex].id)
                            }
                            selectedActorMovieGenreIndex += 1
                        }
                        selectedActorMovieGenreIndex = 0
                        selectedActorMovieIndex += 1
                    }
                }
                selectedActorMovieIndex = 0
                selectedActorIndex += 1
            }
            selectedActorIndex = 0
            selectedGenreIndex += 1
        }
    }
    
    func compareSortedMovieLists() {
        var userOneIndex = 0
        var userTwoIndex = 0
        
        while userOneIndex < userOne.movieIdListAfterGenreSort.count {
            while userTwoIndex < userTwo.movieIdListAfterGenreSort.count {
                if userOne.movieIdListAfterGenreSort[userOneIndex] == userTwo.movieIdListAfterGenreSort[userTwoIndex] {
                    movieListIds.append(userOne.movieIdListAfterGenreSort[userOneIndex])
                    break
                }
                userTwoIndex += 1
            }
            userTwoIndex = 0
            userOneIndex += 1
        }
        movieListIds = movieListIds.uniqued()
    }
}
