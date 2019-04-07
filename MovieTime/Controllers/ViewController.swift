//
//  ViewController.swift
//  MovieTime
//
//  Created by Mike Conner on 2/25/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movieTimeManager = MovieTimeManager()
    
    @IBOutlet weak var resetUserOne: UIBarButtonItem!
    @IBOutlet weak var resetUserTwo: UIBarButtonItem!
    @IBOutlet weak var userOneSelectionsComplete: UIButton!
    @IBOutlet weak var userTwoSelectionsComplete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetUserOne.isEnabled = false
        resetUserTwo.isEnabled = false
        userOneSelectionsComplete.isEnabled = true
        userTwoSelectionsComplete.isEnabled = true
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @IBAction func resetUserOneButton(_ sender: Any) {
        resetUserOne.isEnabled = false
        userOneSelectionsComplete.isEnabled = true
        userOneSelectionsComplete.setImage(UIImage(named: "bubble-empty"), for: .normal)
        movieTimeManager.userOne.areUserSelectionsComplete = false
        movieTimeManager.userOne.userSelectedGenres.removeAll()
        movieTimeManager.userOne.userSelectedActors.removeAll()
        movieTimeManager.userOne.movieIdListAfterGenreSort.removeAll()
        movieTimeManager.apiReturnedUserOneActorMovies.removeAll()
    }
    
    @IBAction func resetUserTwoButton(_ sender: Any) {
        resetUserTwo.isEnabled = false
        userTwoSelectionsComplete.isEnabled = true
        userTwoSelectionsComplete.setImage(UIImage(named: "bubble-empty"), for: .normal)
        movieTimeManager.userTwo.areUserSelectionsComplete = false
        movieTimeManager.userTwo.userSelectedGenres.removeAll()
        movieTimeManager.userTwo.userSelectedActors.removeAll()
        movieTimeManager.userTwo.movieIdListAfterGenreSort.removeAll()
        movieTimeManager.apiReturnedUserTwoActorMovies.removeAll()
    }
    
    @IBAction func makeUserOneSelections(_ sender: Any) {
        movieTimeManager.userOneMakingSelections = true
        performSegue(withIdentifier: "goToGenreTableViewSegue", sender: self)
    }
    
    @IBAction func makeUserTwoSelections(_ sender: Any) {
        movieTimeManager.userOneMakingSelections = false
        performSegue(withIdentifier: "goToGenreTableViewSegue", sender: self)
    }
    
    @IBAction func viewResultsFromUserSelections(_ sender: Any) {
        if movieTimeManager.userOne.areUserSelectionsComplete == true && movieTimeManager.userTwo.areUserSelectionsComplete == true {
            movieTimeManager.determineMovieMatches()
            if movieTimeManager.movieListIds.count > 0 {
            //    getFinalMovies()
                performSegue(withIdentifier: "goToResultsTableViewSegue", sender: self)
            } else {
                showAlert(with: "😢", and: "There are no movies that match the selected criteria.")
            }
        } else {
            showAlert(with: "😢", and: "Please make sure both users have made their selections.")
        }
    }
    
    @IBAction func unwindFromResultsVC(_ sender: UIStoryboardSegue) {
        self.resetUserOneButton(self)
        self.resetUserTwoButton(self)
        self.movieTimeManager.movieListIds.removeAll()
        self.movieTimeManager.finalMovies.removeAll()
    }
    
    @IBAction func unwindFromGenresVC(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindFromActorsVCWhenComplete(_ sender: UIStoryboardSegue) {
        if movieTimeManager.userOneMakingSelections == true {
            movieTimeManager.userOne.areUserSelectionsComplete = true
            userOneSelectionsComplete.setImage(UIImage(named: "bubble-selected"), for: .normal)
            resetUserOne.isEnabled = true
            userOneSelectionsComplete.isEnabled = false
            getListOfUserOneActorMovies()
        } else {
            movieTimeManager.userTwo.areUserSelectionsComplete = true
            userTwoSelectionsComplete.setImage(UIImage(named: "bubble-selected"), for: .normal)
            resetUserTwo.isEnabled = true
            userTwoSelectionsComplete.isEnabled = false
            getListOfUserTwoActorMovies()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGenreTableViewSegue" {
            let navigationVC = segue.destination as? UINavigationController
            let newVC = navigationVC?.viewControllers.first as! GenreTableViewController
            newVC.movieTimeManager = movieTimeManager
        } else {
            let navigationVC = segue.destination as? UINavigationController
            let newVC = navigationVC?.viewControllers.first as! ResultsTableViewController
            newVC.movieTimeManager = movieTimeManager
        }
    }
    
    func getListOfUserOneActorMovies() {
        var indexCounter = 0
        let totalSelectedActors = movieTimeManager.userOne.userSelectedActors.count
        while indexCounter < totalSelectedActors {
            getListOfUserOneActorMovies(actorId: movieTimeManager.userOne.userSelectedActors[indexCounter].id)
            indexCounter += 1
        }
    }
    
    func getListOfUserOneActorMovies(actorId: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(actorId)/movie_credits?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            return
        }
        ResultsManager<ActorMovies>.getAll(url: url) { actorMovies, errors in
            if let actorMovies = actorMovies {
                self.movieTimeManager.apiReturnedUserOneActorMovies.append(actorMovies)
            }
        }
    }
    
    func getListOfUserTwoActorMovies() {
        var indexCounter = 0
        let totalSelectedActors = movieTimeManager.userTwo.userSelectedActors.count
        while indexCounter < totalSelectedActors {
            getListOfUserTwoActorMovies(actorId: movieTimeManager.userTwo.userSelectedActors[indexCounter].id)
            indexCounter += 1
        }
    }
    
    func getListOfUserTwoActorMovies(actorId: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(actorId)/movie_credits?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            return
        }
        ResultsManager<ActorMovies>.getAll(url: url) { actorMovies, errors in
            if let actorMovies = actorMovies {
                self.movieTimeManager.apiReturnedUserTwoActorMovies.append(actorMovies)
            }
        }
    }
}

extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

