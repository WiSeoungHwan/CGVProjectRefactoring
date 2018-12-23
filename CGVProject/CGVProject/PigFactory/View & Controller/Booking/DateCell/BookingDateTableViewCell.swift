//
//  BookingDateTabelViewCell.swift
//  CGVProject
//
//  Created by PigFactory on 27/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class BookingDateTableViewCell: UITableViewCell {

    @IBOutlet weak var bookingDateCollectionView: UICollectionView!
    @IBOutlet weak var movieDateDetails: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        bookingDateCollectionView.reloadData()
    }
}
