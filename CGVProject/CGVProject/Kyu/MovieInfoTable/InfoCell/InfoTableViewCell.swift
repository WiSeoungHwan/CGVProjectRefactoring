//
//  InfoTableViewCell.swift
//  LoginView
//
//  Created by Maru on 30/11/2018.
//  Copyright © 2018 Maru. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var actorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runningTimeLabel: UILabel!
    @IBOutlet weak var openDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
