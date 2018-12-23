//
//  DescriptionTableViewCell.swift
//  CGVProject
//
//  Created by Maru on 05/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.numberOfLines = 0
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
