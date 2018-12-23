//
//  BookingTheaterModel.swift
//  CGVProject
//
//  Created by PigFactory on 19/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

//데이터 처리 #1
class BookingTheaterModel {
    var times: String?
    var audi: String?
    var currentSeat: Int?
    var pk: Int?
    
    init(_ screentime: ScreenTime) {
        times = screentime.times
        audi = screentime.auditoriumName
        currentSeat = screentime.currentSeatsNo
        pk = screentime.pk
    }
    
    
    var sublocation: String?
    
    init(_ subLocation: SubLocation) {
        sublocation = subLocation.subLocation
    }
}
