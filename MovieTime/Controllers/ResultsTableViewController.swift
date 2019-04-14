//
//  ResultsTableViewController.swift
//  MovieTime
//
//  Created by Mike Conner on 2/28/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var movieTimeManager = MovieTimeManager()
    var selectedRow = 0

    override func viewDidLoad() {
        
        // set title bar attributes
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.viewDidLoad()
        getFinalMovies() // call function to contact API to get final movie list
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTimeManager.finalMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movieTimeManager.finalMovies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! MovieCell
        cell.setResult(movie: movie)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "movieDetailSegue", sender: self) // go to MovieDetailViewController when a row is selected
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as? MovieDetailViewController
        
        // Provide information of selected row's movie to MovieDetailViewController
        navigationVC?.movieID = movieTimeManager.finalMovies[selectedRow].id
        navigationVC?.movieDescription = movieTimeManager.finalMovies[selectedRow].overview
        navigationVC?.posterPath = movieTimeManager.finalMovies[selectedRow].posterPath
    }
    
    // Function to call networking code for each movie in the movieListIds array
    func getFinalMovies() {
        var index = 0
        while index < movieTimeManager.movieListIds.count {
            getFinalMovies(movieId: movieTimeManager.movieListIds[index])
            index += 1
        }
    }
    
    // Networking function that provides the movie ID so the APIManager to make the networking call
    func getFinalMovies(movieId: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            return
        }
        APIManager<Movie>.getAll(url: url) { movie, errors in
            DispatchQueue.main.sync {
                if let movie = movie {
                    self.movieTimeManager.finalMovies.append(movie) // add movies to finalMovies array
                    self.movieTimeManager.sortMovies() // function that sorts the movies based on their vote average score from the API
                    self.tableView.reloadData() // reload the tableview once the API call has completed and the movies are sorted
                } else {
                    if let errors = errors {
                        print(errors) // Print error to console
                    }
                }
            }
        }
    }
}
