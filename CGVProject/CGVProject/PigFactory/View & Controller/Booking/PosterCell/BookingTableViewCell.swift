//
//  MainTableViewCell.swift
//  CGVProject
//
//  Created by PigFactory on 26/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    var moviePk: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        posterCollectionView.reloadData()
    }
    
    
}




