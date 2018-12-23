//
//  BookingDate.swift
//  CGVProject
//
//  Created by PigFactory on 27/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class BookingDateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieDay: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    var show: Bool!
    
    //데이터 처리 #2
    var model: BookingDateModel! {
        didSet {
            movieDay.text = model.day
            
            var a = ""
            var b = ""
            b = String((model.date?.popLast())!)
            a = String((model.date?.popLast())!)
            a += b
            movieDate.text = a
            
            show = model.show
        }
    }
}


