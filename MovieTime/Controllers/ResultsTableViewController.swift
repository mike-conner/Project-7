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
        super.viewDidLoad()
        getFinalMovies()
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
        performSegue(withIdentifier: "movieDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationVC = segue.destination as? MovieDetailViewController
        navigationVC?.movieID = movieTimeManager.finalMovies[selectedRow].id
        navigationVC?.movieDescription = movieTimeManager.finalMovies[selectedRow].overview
        navigationVC?.posterPath = movieTimeManager.finalMovies[selectedRow].posterPath
    }
    
    func getFinalMovies() {
        var index = 0
        while index < movieTimeManager.movieListIds.count {
            getFinalMovies(movieId: movieTimeManager.movieListIds[index])
            index += 1
        }
    }
    
    func getFinalMovies(movieId: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            return
        }
        APIManager<Movie>.getAll(url: url) { movie, errors in
            DispatchQueue.main.sync {
                if let movie = movie {
                    self.movieTimeManager.finalMovies.append(movie)
                    self.movieTimeManager.sortMovies()
                    self.tableView.reloadData()
                }
            }
        }
    }
}
