//
//  SeatCollectionViewCell.swift
//  CGVProject
//
//  Created by PigFactory on 30/11/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class SeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var seatView: UIView!
    
    var pk: Int?
    var row: Int?
    var number: Int?
    var seatName: String?
    var reservationCheck: Bool?
    
    
    //데이터 처리 #2
    //예약된 좌석 정보 불러오기
    var model: SeatModel! {
        didSet {
            pk = model.pk
            row = model.row
            number = model.number
            seatName = model.seatName
            reservationCheck = model.reservationCheck
            
            if reservationCheck!{
                seatView.backgroundColor = .black
            }
        }
    }
    
    
}
