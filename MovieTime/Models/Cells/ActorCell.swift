//
//  ActorCell.swift
//  MovieTime
//
//  Created by Mike Conner on 3/2/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import UIKit

class ActorCell: UITableViewCell {

    @IBOutlet weak var actorLabel: UILabel!
    
    func setActor(actor: Actor) {
        actorLabel.text = actor.name
    }
}
