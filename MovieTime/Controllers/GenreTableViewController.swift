//
//  GenreTableViewController.swift
//  MovieTime
//
//  Created by Mike Conner on 2/28/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit 

class GenreTableViewController: UITableViewController {
     
    var movieTimeManager = MovieTimeManager()
    var userSelectGenreCounter: Int = 0
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            return
        }
        
        APIManager<Genres>.getAll(url: url) { genres, errors in
            DispatchQueue.main.sync {
                if let genres = genres {
                    self.movieTimeManager.apiReturnedGenres = genres
                    self.reloadData()
                }
            }
        }
    }
    
    @IBAction func goToActorsTableVC(_ sender: Any) {
        if userSelectGenreCounter == 0 {
            showAlert(with: "😢", and: "You must select at least one Genre.")
            return
        }
        performSegue(withIdentifier: "goToActorsTableViewSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToActorsTableViewSegue" {
            let navigationVC = segue.destination as? UINavigationController
            let newVC = navigationVC?.viewControllers.first as! ActorTableViewController
            newVC.movieTimeManager = movieTimeManager
        }
    }
    
    @IBAction func unwindFromActorsVC(_ sender: UIStoryboardSegue) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTimeManager.apiReturnedGenres.genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genre = movieTimeManager.apiReturnedGenres.genres[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "genreCell") as! GenreCell
        cell.setGenre(genre: genre)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userSelectGenreCounter < 5 {
            selectedGenres(indexPath: indexPath)
            userSelectGenreCounter += 1
        } else {
            showAlert(with: "😢", and: "There is a maximum of 5 selections.")
            tableView.deselectRow(at: indexPath, animated: false )
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var temporaryIndex = 0
        if movieTimeManager.userOneMakingSelections == true {
            while temporaryIndex < userSelectGenreCounter {
                if movieTimeManager.userOne.userSelectedGenres[temporaryIndex].name == movieTimeManager.apiReturnedGenres.genres[indexPath.row].name {
                    movieTimeManager.userOne.userSelectedGenres.remove(at: temporaryIndex)
                    break
                }
                temporaryIndex += 1
            }
            userSelectGenreCounter -= 1
        } else {
            while temporaryIndex < userSelectGenreCounter {
                if movieTimeManager.userTwo.userSelectedGenres[temporaryIndex].name == movieTimeManager.apiReturnedGenres.genres[indexPath.row].name {
                    movieTimeManager.userTwo.userSelectedGenres.remove(at: temporaryIndex)
                    break
                }
                temporaryIndex += 1
            }
            userSelectGenreCounter -= 1
        }
    }
    
    func selectedGenres(indexPath: IndexPath) {
        let selectedGenre = movieTimeManager.apiReturnedGenres.genres[indexPath.row]
        if movieTimeManager.userOneMakingSelections == true {
            movieTimeManager.userOne.userSelectedGenres.append(selectedGenre)
        } else {
            movieTimeManager.userTwo.userSelectedGenres.append(selectedGenre)
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
