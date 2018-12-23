//
//  BookingMovieTitleCell.swift
//  CGVProject
//
//  Created by PigFactory on 27/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class BookingTableMovieTitleCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieInfo: UILabel!
    
    
    //데이터 처리 #2
    
    //    var model: MovieDetail! {
    //        didSet {
    //            movieTitle?.text = model.title
    //            movieInfo?.text = String(model.durationMin!)
    //        }
    //    }
    
    var model: MovieTitleModel! {
        didSet {
            movieTitle?.text = model.movieTitle
            movieInfo?.text = ("청소년관람불가 / 상영시간: \(model.duration!)분")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
