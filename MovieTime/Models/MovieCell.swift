//
//  MovieCell.swift
//  MovieTime
//
//  Created by Mike Conner on 3/3/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    
    func setResult(movie: Movie) {
        resultLabel.text = movie.title
    }
}
