//
//  ActorTableViewController.swift
//  MovieTime
//
//  Created by Mike Conner on 2/28/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ActorTableViewController: UITableViewController {
    
    var movieTimeManager = MovieTimeManager()
    var userSelectActorCounter: Int = 0
    let maxAllowableActorSelections: Int = 5
    let maxAllowableActorPages: Int = 3

    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        
        // set title bar attributes
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 25)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.viewDidLoad()
        doneButton.isEnabled = false
        
        getActors()
    }
    
    // dismiss the ActorTableViewController and go back to GenreTableViewController
    @IBAction func goBackToGenresVC(_ sender: Any) {
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTimeManager.apiReturnedActors.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actor = movieTimeManager.apiReturnedActors.results[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell") as! ActorCell
        cell.setActor(actor: actor)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Calls function that adds actors from userSelectedActors array if selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userSelectActorCounter < maxAllowableActorSelections {
            selectedActors(indexPath: indexPath)
            userSelectActorCounter += 1
        } else {
            showAlert(with: "😢", and: "There is a maximum of \(maxAllowableActorSelections) selections.")
            tableView.deselectRow(at: indexPath, animated: false )
        }
        if userSelectActorCounter > 0 {
            doneButton.isEnabled = true
        }
    }
    
    // Removes actors from userSelectedActors array if deselected
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var temporaryIndex = 0
        if movieTimeManager.userOneMakingSelections == true {
            while temporaryIndex < userSelectActorCounter {
                if movieTimeManager.userOne.userSelectedActors[temporaryIndex].name == movieTimeManager.apiReturnedActors.results[indexPath.row].name {
                    movieTimeManager.userOne.userSelectedActors.remove(at: temporaryIndex)
                    break
                }
                temporaryIndex += 1
            }
            userSelectActorCounter -= 1
        } else {
            while temporaryIndex < userSelectActorCounter {
                if movieTimeManager.userTwo.userSelectedActors[temporaryIndex].name == movieTimeManager.apiReturnedActors.results[indexPath.row].name {
                    movieTimeManager.userTwo.userSelectedActors.remove(at: temporaryIndex)
                    break
                }
                temporaryIndex += 1
            }
            userSelectActorCounter -= 1
        }
        
        if userSelectActorCounter == 0 {
            doneButton.isEnabled = false
        }
    }
    
    // function that addes user selected actors to userSelectedActors array
    func selectedActors(indexPath: IndexPath) {
        let selectedActor = movieTimeManager.apiReturnedActors.results[indexPath.row]
        if movieTimeManager.userOneMakingSelections == true {
            movieTimeManager.userOne.userSelectedActors.append(selectedActor)
        } else {
            movieTimeManager.userTwo.userSelectedActors.append(selectedActor)
        }
    }
    
    // Code below creates the URL and makes the call to the API which returns all the available actors
    func getActors() {
        var page = 1
        while page <= maxAllowableActorPages {
            getActors(from: page)
            page += 1
        }
    }
    
    func getActors(from page: Int) {
        guard let url = URL(string: "https://api.themoviedb.org/3/person/popular?api_key=164f5af1e46d0911dd1fc6fa484e7abe&language=en-US&page=\(page)") else {
            return
        }
        
        APIManager<Actors>.getAll(url: url) { actors, errors in
            DispatchQueue.main.sync {
                if let actors = actors {
                    self.movieTimeManager.apiReturnedActors.results.append(contentsOf: actors.results) // Append next page of actors from API call to array
                    self.reloadData() // call function to reload tableview once API call is completed
                } else {
                    if let errors = errors {
                        print(errors) // Print error to console
                    }
                }
            }
        }
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
