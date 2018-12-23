//
//  SeatModel.swift
//  CGVProject
//
//  Created by PigFactory on 17/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

//데이터 처리 #1
class SeatModel {
    var pk: Int
    var row: Int
    var number: Int
    var seatName: String?
    var reservationCheck: Bool
    
    init(_ seat: TheaterSeats) {
        pk = seat.pk
        row = seat.row
        number = seat.number
        seatName = seat.seatName
        reservationCheck = seat.reservationCheck
    }
}
