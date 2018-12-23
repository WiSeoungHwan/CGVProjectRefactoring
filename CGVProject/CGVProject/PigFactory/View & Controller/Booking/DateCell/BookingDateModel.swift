//
//  BookingDateModel.swift
//  CGVProject
//
//  Created by PigFactory on 17/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

//데이터 처리 #1
class BookingDateModel {
    var day: String?
    var date: String?
    var show: Bool?
    
    init(_ dateElement: DateElement) {
        day = dateElement.weekday
        date = dateElement.date
        show = dateElement.show
    }
}
