//
//  MovieDetailViewController.swift
//  MovieTime
//
//  Created by Mike Conner on 4/13/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailInformation: UITextView!
    
    var movieID = 0
    var movieDescription = ""
    var posterPath = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPoster()
        movieDetailInformation.text = "\(movieDescription)"
    }
    
    func getPoster() {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                self.movieDetailImage.image = UIImage(data: data!)
            }
        }.resume()
        
    }
    
}
