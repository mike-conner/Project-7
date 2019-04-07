//
//  GenreCell.swift
//  MovieTime
//
//  Created by Mike Conner on 3/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell {

    @IBOutlet weak var genreLabel: UILabel!
    
    func setGenre(genre: Genre) {
        genreLabel.text = genre.name
    }
}
