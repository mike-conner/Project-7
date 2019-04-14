//
//  ViewController.swift
//  MovieTime
//
//  Created by Mike Conner on 2/25/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // create the app manager object
    var movieTimeManager = MovieTimeManager()
    
    @IBOutlet weak var resetUserOne: UIBarButtonItem!
    @IBOutlet weak var resetUserTwo: UIBarButtonItem!
    @IBOutlet weak var userOneSelectionsComplete: UIButton!
    @IBOutlet weak var userTwoSelectionsComplete: UIButton!
    
    override func viewDidLoad() {
        
        // set title bar attributes
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.viewDidLoad()
        
        resetUserOne.isEnabled = false
        resetUserTwo.isEnabled = false
        userOneSelectionsComplete.isEnabled = true
        userTwoSelectionsComplete.isEnabled = true
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
                performSegue(withIdentifier: "goToResultsTableViewSegue", sender: self)
            } else {
                showAlert(with: "😢", and: "There are no movies that match the selected criteria. Perhaps you should play a board game instead?")
            }
        } else {
            showAlert(with: "😢", and: "Please make sure both users have made their selections.")
        }
    }
    
    // called when user selects "Clear" on ResultsTableViewController Navbar
    @IBAction func unwindFromResultsVC(_ sender: UIStoryboardSegue) {
        self.resetUserOneButton(self)
        self.resetUserTwoButton(self)
        self.movieTimeManager.movieListIds.removeAll()
        self.movieTimeManager.finalMovies.removeAll()
    }
    
    // called when user selects "Back" from GenreTableViewController Navbar
    @IBAction func unwindFromGenresVC(_ sender: UIStoryboardSegue) {
        // doesn't actually do anything since nothing was done that needs to be undone, but without it the "Back" button doesn't work
    }
    
    // called when user selects "Done" from ActorTableViewController Navbar. Goes back to main page for the other user to make selections or, if they already have, to see the results
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
    
    // Determine which VC to segue to; either GenreTableViewController or ResultsTableViewController
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
    
    // Function used to call networking code for each actor selected by passing the actor ID to the neworking function.
    func getListOfUserOneActorMovies() {
        var indexCounter = 0
        let totalSelectedActors = movieTimeManager.userOne.userSelectedActors.count
        while indexCounter < totalSelectedActors {
            getListOfUserOneActorMovies(actorId: movieTimeManager.userOne.userSelectedActors[indexCounter].id)
            indexCounter += 1
        }
    }
    
    // Networking function that provides the URL and actor ID so the APIManager to make the networking call
    func getListOfUserOneActorMovies(actorId: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/\(actorId)/movie_credits?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US") else {
            return // Return if URL creation fails.
        }
        APIManager<ActorMovies>.getAll(url: url) { actorMovies, errors in
            if let actorMovies = actorMovies {
                self.movieTimeManager.apiReturnedUserOneActorMovies.append(actorMovies) // Create/append an array of all movies that match user one's Genre and Actor selections
            } else {
                if let errors = errors {
                    print(errors) // Print error to console
                }
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
        APIManager<ActorMovies>.getAll(url: url) { actorMovies, errors in
            if let actorMovies = actorMovies {
                self.movieTimeManager.apiReturnedUserTwoActorMovies.append(actorMovies)
            } else {
                if let errors = errors {
                    print(errors) // Print error to console
                }
            }
        }
    }
}

// Extension to present alerts easily 
extension UIViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

