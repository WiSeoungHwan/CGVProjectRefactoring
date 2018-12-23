//
//  TheaterReservation.swift
//  CGVProject
//
//  Created by Wi on 18/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

struct TheaterReservation : Codable {
    let pk: Int // 예약번호
    let screeningSet: ScreeningSet
    let num: Int    // 인원수
    let seatsReserved: [SeatsReserved]
    let isActive: Bool
    
}

struct ScreeningSet: Codable {
    let imgUrl, thumbImgUrl: String
    let title, age, theater, time: String
}

struct SeatsReserved: Codable {
    let seatName: String
}
