//
//  BookingTheaterTableViewCell.swift
//  CGVProject
//
//  Created by PigFactory on 28/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class BookingTheaterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeTableCollectionCell: UICollectionView!
    
    @IBOutlet weak var theaterName: UILabel!
    @IBOutlet weak var theaterSection: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        timeTableCollectionCell.reloadData()
    }
    
    var model: BookingTheaterModel! {
        
        didSet {
            theaterName.text = model.sublocation
            theaterSection.text = model.audi
            //            posterView.kf.setImage(with: URL(string: model.moviePosterImageUrl))
        }
    }
    
}

